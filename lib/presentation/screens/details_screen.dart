import 'package:flutter/material.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:imgur/domain/entitites/gallery_image_entity.dart';
import 'package:imgur/presentation/widgets/custom_network_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    this.extraData,
  });

  final Map<String, dynamic>? extraData;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late GalleryEntity _galleryEntity;

  @override
  void initState() {
    _galleryEntity = GalleryEntity.fromJson(widget.extraData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildMainContent());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Gallery id: ${_galleryEntity.id ?? "No title"}"),
    );
  }

  Widget _buildMainContent() {
    return ListView(
      children: [
        _buildGalleryImage(),
        Flexible(flex: 2, child: _buildGalleryData()),
      ],
    );
  }

  Widget _buildGalleryData() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContentHeader(),
          const SizedBox(height: 10),
          _buildContent(),
          const SizedBox(height: 10),
          _buildImagesSection(),
        ],
      ),
    );
  }

  Widget _buildImagesSection() {
    if (_galleryEntity.images.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Text("No more images"),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            "Other images",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          ..._galleryEntity.images.map(
            (GalleryImageEntity image) => CustomNetworkImage(imageUrl: image.link ?? ""),
          )
        ],
      ),
    );
  }

  Container _buildContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _galleryEntity.title ?? "No title",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 16),
          Text(
            _galleryEntity.description ?? "No description",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Container _buildContentHeader() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      color: Colors.green[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Text(
              _galleryEntity.id ?? "No id",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: (_galleryEntity.favorite ?? false) ? const Icon(Icons.favorite_outline) : const Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryImage() {
    return SizedBox(
      width: double.maxFinite,
      height: 300,
      child: CustomNetworkImage(imageUrl: _galleryEntity.images.first.link!),
    );
  }
}
