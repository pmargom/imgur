import 'package:dartz/dartz.dart';
import 'package:imgur/core/errors/server_failure.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';

abstract class GalleryRepository {
  Future<Either<Failure, List<GalleryEntity>>> getGalleries(String query, [String sort = "top", int page = 1]);
  Future<Either<Failure, GalleryEntity?>> getGallery(int id);
}
