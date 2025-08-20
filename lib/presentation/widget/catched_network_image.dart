 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CatchedNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const CatchedNetworkImage(
      {super.key, required this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: "https:$url",
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
