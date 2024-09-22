import 'package:get_it/get_it.dart';
import 'package:imgur/core/network/services_base_api.dart';
import 'package:imgur/data/datasources/remote_datasource.dart';
import 'package:imgur/data/repositories/gallery_repository_impl.dart';
import 'package:imgur/domain/repositories/gallery_repository.dart';
import 'package:imgur/domain/usecases/get_galleries_usecase.dart';
import 'package:imgur/presentation/cubits/home/galleries_cubit.dart';

final getIt = GetIt.instance;

void initDependencies() {
  // Bloc
  getIt.registerLazySingleton<GalleriesCubit>(() => GalleriesCubit(getIt()));
  // Use cases

  getIt.registerLazySingleton<GetGalleriesUsecase>(() => GetGalleriesUsecase(getIt()));
  // Repositories
  getIt.registerLazySingleton<GalleryRepository>(() => GalleryRepositoryImpl(getIt()));

  // Data sources
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(getIt()));
  // Api service
  getIt.registerLazySingleton(() => ServicesBaseApi());
}
