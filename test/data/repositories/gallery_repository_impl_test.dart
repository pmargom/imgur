import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imgur/data/models/gallery_model.dart';
import 'package:imgur/data/repositories/gallery_repository_impl.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late GalleryRepositoryImpl galleryRepositoryImpl;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    galleryRepositoryImpl = GalleryRepositoryImpl(mockRemoteDataSource);
  });

  const List<GalleryEntity> galleryEntities = [
    GalleryEntity(
      id: "id 1",
      title: "title 1",
      description: null,
      link: "https://",
      favorite: true,
      images: [],
    ),
    GalleryEntity(
      id: "id 2",
      title: "title 2",
      description: null,
      link: "https://",
      favorite: true,
      images: [],
    ),
  ];

  const List<GalleryModel> galleryModels = [
    GalleryModel(
      id: "id 1",
      title: "title 1",
      description: null,
      link: "https://",
      favorite: true,
      images: [],
    ),
    GalleryModel(
      id: "id 2",
      title: "title 2",
      description: null,
      link: "https://",
      favorite: true,
      images: [],
    ),
  ];

  const String query = "cars";

  group('get current galleries', () {
    test(
      'should return gallery list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getGalleries(query)).thenAnswer(
          (_) async => galleryModels,
        );

        // act
        final result = await galleryRepositoryImpl.getGalleries(query);

        // assert
        expect(result, equals(const Right(galleryEntities)));
      },
    );
  });
}
