import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ImageProductWidget extends StatelessWidget {
  final String imgUrl;
  const ImageProductWidget({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 300,
      imageUrl: imgUrl,
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
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Ionicons.alert_circle_outline),
            SizedBox(
              height: 12,
            ),
            Text('Image is not available')
          ],
        );
      },
    );
  }
}
