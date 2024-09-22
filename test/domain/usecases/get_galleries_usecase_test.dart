import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:imgur/domain/usecases/get_galleries_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetGalleriesUsecase getGalleriesUsecase;
  late MockGalleryRepository mockGalleryRepository;

  setUp(() {
    mockGalleryRepository = MockGalleryRepository();
    getGalleriesUsecase = GetGalleriesUsecase(mockGalleryRepository);
  });

  const String query = "cars";

  List<GalleryEntity> galleryEntities = [
    const GalleryEntity(
      id: "id 1",
      title: "title 1",
      description: null,
      link: "https://",
      favorite: true,
      images: [],
    ),
    const GalleryEntity(
      id: "id 2",
      title: "title 2",
      description: null,
      link: "https://",
      favorite: true,
      images: [],
    ),
  ];

  test("should get a list of galleries", () async {
    // arrange
    when(mockGalleryRepository.getGalleries(query)).thenAnswer(
      (_) async => Right(galleryEntities),
    );

    // act
    final result = await getGalleriesUsecase(query);

    // assert
    expect(result, Right(galleryEntities));
  });

  test("should get the same number of galleries", () async {
    // arrange
    when(mockGalleryRepository.getGalleries(query)).thenAnswer(
      (_) async => Right(galleryEntities),
    );

    // act
    final result = await getGalleriesUsecase(query);

    // assert
    expect(result.length(), Right(galleryEntities).length());
  });

  test("should get the empty list when searching using empty string", () async {
    // arrange
    when(mockGalleryRepository.getGalleries("")).thenAnswer(
      (_) async => const Right(<GalleryEntity>[]),
    );

    // act
    final result = await getGalleriesUsecase("");

    // assert
    expect(result, const Right(<GalleryEntity>[]));
  });
}
