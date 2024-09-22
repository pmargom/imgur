import 'package:equatable/equatable.dart';
import 'package:imgur/domain/entitites/gallery_image_entity.dart';

class GalleryImageModel extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? type;
  final String? link;

  const GalleryImageModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.link,
  });

  GalleryImageModel copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? link,
  }) =>
      GalleryImageModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        type: type ?? this.type,
        link: link ?? this.link,
      );

  static GalleryImageModel fromJson(json) {
    return GalleryImageModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      type: json["type"],
      link: json["link"],
    );
  }

  static List<GalleryImageModel> fromJsonList(List json) => List<GalleryImageModel>.from(json.map((json) => GalleryImageModel.fromJson(json)));

  @override
  List<Object?> get props => [id, title, description, type, link];
}

extension GalleryImageModelExtension on GalleryImageModel {
  GalleryImageEntity get asEntiy => GalleryImageEntity(
        id: id,
        title: title,
        description: description,
        type: type,
        link: link,
      );
}
