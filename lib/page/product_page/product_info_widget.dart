import 'package:study_app/module/models/dto/product_dto.dart';
import 'package:flutter/material.dart';

import '../../utils/convert_color.dart';

class ProductInfoWidget extends StatelessWidget {
  final ProductDto productItem;
  const ProductInfoWidget({Key? key, required this.productItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(productItem.errorDescription),
        Text(
          productItem.sku,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        productItem.color != null
            ? Text(ConvertColor.convert(productItem.color!))
            : const Text('---')
      ],
    );
  }
}
