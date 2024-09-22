import 'package:imgur/domain/entitites/gallery_image_entity.dart';

class GalleryEntity {
  final String? id;
  final String? title;
  final String? description;
  final String? link;
  final bool? favorite;
  final List<GalleryImageEntity> images;

  GalleryEntity({
    this.id,
    this.title,
    this.description,
    this.link,
    this.favorite,
    required this.images,
  });

  GalleryEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? link,
    bool? favorite,
    List<GalleryImageEntity>? images,
  }) =>
      GalleryEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        link: link ?? this.link,
        favorite: favorite ?? this.favorite,
        images: images ?? this.images,
      );

  static GalleryEntity fromJson(json) {
    return GalleryEntity(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      link: json["link"],
      favorite: false,
      images: GalleryImageEntity.fromJsonList(json["images"]),
    );
  }

  static List<GalleryEntity> fromJsonList(List json) => List<GalleryEntity>.from(json.map((json) => GalleryEntity.fromJson(json)));
}
