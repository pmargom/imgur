import 'package:dio/dio.dart';
import 'package:imgur/core/network/services_base_api.dart';
import 'package:imgur/data/datasources/remote_datasource.dart';
import 'package:imgur/domain/repositories/gallery_repository.dart';
import 'package:imgur/domain/usecases/get_galleries_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    GalleryRepository,
    GetGalleriesUsecase,
    RemoteDataSource,
    ServicesBaseApi,
    Dio,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
