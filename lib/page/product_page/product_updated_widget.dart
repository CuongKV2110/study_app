import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../constants/constants.dart';
import '../../module/models/dto/product_dto.dart';
import '../../utils/convert_color.dart';

class ProductUpdatedWidget extends StatelessWidget {
  final ProductDto productItem;
  const ProductUpdatedWidget({Key? key, required this.productItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
          color: colorWhiteF0,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: productItem.image,
                  height: 120,
                  width: 120,
                  errorWidget: (context, url, error) {
                    return const Icon(Ionicons.alert_circle_outline);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productItem.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      productItem.errorDescription,
                    ),
                    Text(
                      productItem.sku,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    productItem.color != null
                        ? Text(ConvertColor.convert(productItem.color!))
                        : const Text('---')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
