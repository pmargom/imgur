import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: _loadingBuilder,
      errorBuilder: _errorBuilder,
    );
  }

  Widget _loadingBuilder(_, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    } else {
      return Center(
        child: CircularProgressIndicator(
          value:
              loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
        ),
      );
    }
  }

  Widget _errorBuilder(_, __, ___) => const Center(
        child: Text('Error during image loading'),
      );
}
