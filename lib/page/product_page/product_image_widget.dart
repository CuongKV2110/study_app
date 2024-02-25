import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProductImageWidget extends StatelessWidget {
  final String imgUrl;
  const ProductImageWidget({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: 120,
      width: 120,
      placeholder: (context, url) {
        return const SizedBox(
          height: 30.0,
          width: 30.0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return const Icon(Ionicons.alert_circle_outline);
      },
    );
  }
}
