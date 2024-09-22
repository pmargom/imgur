import 'package:dio/dio.dart';
import 'package:imgur/core/errors/server_exception.dart';
import 'package:imgur/core/network/services_base_api.dart';
import 'package:imgur/data/models/gallery_model.dart';

abstract class RemoteDataSource {
  Future<List<GalleryModel>> getGalleries(String query, [String sort = "top", int page = 1]);
  Future<GalleryModel?> getGallery(int id);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final ServicesBaseApi _serviceBaseApi;

  RemoteDataSourceImpl(this._serviceBaseApi);

  @override
  Future<List<GalleryModel>> getGalleries(
    String query, [
    String sort = "top",
    int page = 1,
  ]) async {
    List<GalleryModel> galleriesList = [];
    final Map<String, dynamic> queryParameters = {};
    try {
      Response? response = await _serviceBaseApi.get("gallery/search/$sort/year/$page?q=$query", queryParameters: queryParameters);

      if (response != null) {
        galleriesList = GalleryModel.fromJsonList(response.data["data"]);
        return galleriesList;
      }
    } catch (e) {
      throw ServerException();
    }

    return galleriesList;
  }

  @override
  Future<GalleryModel?> getGallery(int id) async {
    GalleryModel? gallery;
    try {
      Response? response = await _serviceBaseApi.get("anime/$id", queryParameters: {});

      if (response != null) {
        gallery = GalleryModel.fromJson(response.data["data"]);
      }
    } catch (e) {
      throw ServerException();
    }

    return gallery;
  }
}
