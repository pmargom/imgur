import 'package:dartz/dartz.dart';
import 'package:imgur/core/errors/server_failure.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:imgur/domain/repositories/gallery_repository.dart';

class GetGalleriesUsecase {
  final GalleryRepository _repository;

  GetGalleriesUsecase(this._repository);

  Future<Either<Failure, List<GalleryEntity>>> call(String query, [String sort = "top", int page = 1]) async {
    return await _repository.getGalleries(query, sort, page);
  }
}
