import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:imgur/core/errors/server_failure.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:imgur/presentation/cubits/home/galleries_cubit.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetGalleriesUsecase mockGetGalleriesUsecase;
  late GalleriesCubit galleriesCubit;

  setUp(() {
    mockGetGalleriesUsecase = MockGetGalleriesUsecase();
    galleriesCubit = GalleriesCubit(mockGetGalleriesUsecase);
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

  test('initial state should be initial', () {
    expect(galleriesCubit.state, GalleriesInitial());
  });

  blocTest<GalleriesCubit, GalleriesState>(
    "should emit [GalleriesLoading, GalleriesLoaded] when data is retrieved successfully",
    build: () {
      when(mockGetGalleriesUsecase("cars")).thenAnswer((_) async => const Right(galleryEntities));
      return galleriesCubit;
    },
    act: (cubit) => cubit.getGalleries("cars"),
    wait: const Duration(milliseconds: 500),
    expect: () => [GalleriesLoading(galleryEntities), GalleriesLoaded(galleryEntities, 1)],
  );

  blocTest<GalleriesCubit, GalleriesState>(
    "should emit [GalleriesLoading, GalleriesError] when data is retrieved unsuccessfully",
    build: () {
      when(mockGetGalleriesUsecase("cars")).thenAnswer((_) async => Left(ServerFailure()));
      return galleriesCubit;
    },
    act: (cubit) => cubit.getGalleries("cars"),
    wait: const Duration(milliseconds: 500),
    expect: () => [GalleriesLoading(galleryEntities), GalleriesError("Server failure")],
  );

  blocTest<GalleriesCubit, GalleriesState>(
    "should emit [GalleriesInitial] when cubit is reset",
    build: () {
      when(mockGetGalleriesUsecase("cars")).thenAnswer((_) async => const Right(galleryEntities));
      return galleriesCubit;
    },
    act: (cubit) => cubit.reset(),
    expect: () => [GalleriesInitial()],
  );
}
