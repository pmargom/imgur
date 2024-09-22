import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:imgur/data/models/gallery_image_model.dart';
import 'package:imgur/data/models/gallery_model.dart';

import '../../helpers/json_reader.dart';

void main() {
  final testGalleryModel = <GalleryModel>[
    const GalleryModel(
      id: "id 1",
      title: "title 1",
      description: null,
      link: "https://",
      favorite: false,
      images: [
        GalleryImageModel(
          id: "image id 1",
          title: null,
          description: null,
          type: "video/mp4",
          link: "https://",
        ),
      ],
    )
  ];

  final testGalleryModelWithNoImages = <GalleryModel>[
    const GalleryModel(
      id: "id 1",
      title: "title 1",
      description: null,
      link: "https://",
      favorite: false,
      images: [],
    )
  ];

  test("should return a valid model from json", () async {
    //arrange

    final List<dynamic> jsonList = json.decode(
      readJson('helpers/mock_data/mock_gallery_search_response.json'),
    );

    //act
    final result = GalleryModel.fromJsonList(jsonList);

    //assert
    expect(result, equals(testGalleryModel));
  });

  test("should return a valid model from json with no images", () async {
    //arrange

    final List<dynamic> jsonList = json.decode(
      readJson('helpers/mock_data/mock_gallery_search_response_empty_images.json'),
    );

    //act
    final result = GalleryModel.fromJsonList(jsonList);

    //assert
    expect(result, equals(testGalleryModelWithNoImages));
  });
}
