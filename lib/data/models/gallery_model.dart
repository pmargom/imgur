import 'package:imgur/data/models/gallery_image_model.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:imgur/domain/entitites/gallery_image_entity.dart';

class GalleryModel {
  final String? id;
  final String? title;
  final String? description;
  final String? link;
  final bool? favorite;
  final List<GalleryImageModel> images;

  GalleryModel({
    this.id,
    this.title,
    this.description,
    this.link,
    this.favorite,
    required this.images,
  });

  GalleryModel copyWith({
    String? id,
    String? title,
    String? description,
    String? link,
    bool? favorite,
    List<GalleryImageModel>? images,
  }) =>
      GalleryModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        link: link ?? this.link,
        favorite: favorite ?? this.favorite,
        images: images ?? this.images,
      );

  static GalleryModel fromJson(json) {
    return GalleryModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      link: json["link"],
      favorite: json["favorite"] ?? false,
      images: json["images"] == null ? [] : GalleryImageModel.fromJsonList(json["images"]),
    );
  }

  static List<GalleryModel> fromJsonList(List json) => List<GalleryModel>.from(json.map((json) => GalleryModel.fromJson(json)));
}

extension GalleryModelExtension on GalleryModel {
  GalleryEntity get asEntity => GalleryEntity(
        id: id,
        title: title,
        description: description,
        link: link,
        favorite: favorite,
        images: images.map<GalleryImageEntity>((GalleryImageModel galleryImage) => galleryImage.asEntiy).toList(),
      );
}
