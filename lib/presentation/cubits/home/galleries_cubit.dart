import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:imgur/domain/entitites/gallery_image_entity.dart';
import 'package:imgur/domain/usecases/get_galleries_usecase.dart';

part 'galleries_state.dart';

class GalleriesCubit extends Cubit<GalleriesState> {
  late int _page;

  final GetGalleriesUsecase _getGalleriesUsecase;

  GalleriesCubit(this._getGalleriesUsecase) : super(GalleriesInitial());

  void reset() {
    emit(GalleriesInitial());
  }

  Future<void> getGalleries(String query, {String sort = "top", int page = 1}) async {
    if (state is GalleriesLoading) {
      return;
    }

    _page = page;

    final currentState = state;

    List<GalleryEntity> oldGalleries = [];

    if (currentState is GalleriesLoaded) {
      final List<GalleryEntity> galleriesWithPictures = _onlyWithImages(currentState.galleries);
      oldGalleries = galleriesWithPictures;
    }

    emit(GalleriesLoading(oldGalleries, isFirstFetch: _page == 1));

    final failureOrData = await _getGalleriesUsecase(query, sort, page);

    failureOrData.fold(
      (failure) => emit(GalleriesError(failure.toString())),
      (newGalleries) {
        List<GalleryEntity> galleries = (state as GalleriesLoading).oldGalleries;
        List<GalleryEntity> newGalleriesWithImages = _onlyWithImages(newGalleries);

        if (_page == 1) {
          galleries = newGalleriesWithImages;
        } else {
          galleries += newGalleriesWithImages;
        }
        _page++;

        emit(GalleriesLoaded(galleries, _page));
      },
    );
  }

  List<GalleryEntity> _onlyWithImages(List<GalleryEntity> galleries) {
    return galleries.where((GalleryEntity gallery) => _firstmage(gallery) != null).toList();
  }

  String? _firstmage(GalleryEntity galleryEntity) {
    if (galleryEntity.images.isEmpty) {
      return null;
    }

    final List<GalleryImageEntity?> images =
        galleryEntity.images.where((GalleryImageEntity galleryImage) => galleryImage.type == "image/jpeg").toList();

    if (images.isEmpty) {
      return null;
    }

    return images.first?.link;
  }
}
