import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imgur/core/errors/server_exception.dart';
import 'package:imgur/data/datasources/remote_datasource.dart';
import 'package:imgur/data/models/gallery_model.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockServicesBaseApi mockServicesBaseApi;
  late RemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockServicesBaseApi = MockServicesBaseApi();
    remoteDataSourceImpl = RemoteDataSourceImpl(mockServicesBaseApi);
  });

  const String query = "";

  group('get galleries', () {
    test('should return list of gallery model when the response code is 200', () async {
      //arrange
      final String url = Uri.parse("gallery/search/top/year/1?q=$query").toString();

      final responseData = {"data": [], "success": true, "status": 200};

      final response = Response(
        requestOptions: RequestOptions(path: url),
        data: responseData,
        statusCode: 200,
      );

      when(mockServicesBaseApi.get(url, queryParameters: {})).thenAnswer((_) async => response);

      //act
      final result = await remoteDataSourceImpl.getGalleries("");

      //assert
      expect(result, isA<List<GalleryModel>>());
    });

    test(
      'should throw a server exception when the response code is 400 or other',
      () async {
        //arrange
        final String url = Uri.parse("/unknown").toString();

        final response = Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 404,
        );

        when(mockServicesBaseApi.get(url, queryParameters: {})).thenAnswer((_) async => response);

        //act
        final result = remoteDataSourceImpl.getGalleries("");

        //assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
