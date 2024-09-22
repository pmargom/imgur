import 'package:dartz/dartz.dart';
import 'package:imgur/core/errors/server_failure.dart';
import 'package:imgur/data/datasources/remote_datasource.dart';
import 'package:imgur/data/models/gallery_model.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:imgur/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final RemoteDataSource _remoteDataSource;

  GalleryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<GalleryEntity>>> getGalleries(String query, [String sort = "top", int page = 1]) async {
    try {
      final List<GalleryModel> galleryModels = await _remoteDataSource.getGalleries(query, sort, page);

      final List<GalleryEntity> galleryEntities = galleryModels.map((GalleryModel galleryModel) => galleryModel.asEntity).toList();
      return Right(galleryEntities);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GalleryEntity?>> getGallery(int id) async {
    try {
      final GalleryModel? galleryModel = await _remoteDataSource.getGallery(id);

      final GalleryEntity? galleryEntity = galleryModel?.asEntity;
      return Right(galleryEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
