part of 'galleries_cubit.dart';

abstract class GalleriesState extends Equatable {}

class GalleriesInitial extends GalleriesState {
  @override
  List<Object?> get props => [];
}

class GalleriesLoading extends GalleriesState {
  final List<GalleryEntity> oldGalleries;
  final bool isFirstFetch;

  GalleriesLoading(this.oldGalleries, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [];
}

class GalleriesLoaded extends GalleriesState {
  final List<GalleryEntity> galleries;
  final int page;

  GalleriesLoaded(this.galleries, this.page);

  @override
  List<Object?> get props => [];
}

class GalleriesError extends GalleriesState {
  final String message;

  GalleriesError(this.message);

  @override
  List<Object?> get props => [];
}
