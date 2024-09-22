class GalleryImageEntity {
  final String? id;
  final String? title;
  final String? description;
  final String? type;
  final String? link;

  GalleryImageEntity({
    this.id,
    this.title,
    this.description,
    this.type,
    this.link,
  });

  GalleryImageEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? link,
  }) =>
      GalleryImageEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        type: type ?? this.type,
        link: link ?? this.link,
      );

  static GalleryImageEntity fromJson(json) {
    return GalleryImageEntity(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      type: json["type"],
      link: json["link"],
    );
  }

  static List<GalleryImageEntity> fromJsonList(List json) => List<GalleryImageEntity>.from(json.map((json) => GalleryImageEntity.fromJson(json)));
}
