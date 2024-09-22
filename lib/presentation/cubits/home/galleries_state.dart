part of 'galleries_cubit.dart';

abstract class GalleriesState {}

class GalleriesInitial extends GalleriesState {}

class GalleriesLoading extends GalleriesState {
  final List<GalleryEntity> oldGalleries;
  final bool isFirstFetch;

  GalleriesLoading(this.oldGalleries, {this.isFirstFetch = false});
}

class GalleriesLoaded extends GalleriesState {
  final List<GalleryEntity> galleries;
  final int page;

  GalleriesLoaded(this.galleries, this.page);
}

class GalleriesError extends GalleriesState {
  final String message;

  GalleriesError(this.message);
}
