import 'package:study_app/module/models/dto/product_dto.dart';
import 'package:study_app/utils/convert_color.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';
import '../../constants/constants.dart';
import '../edit_product_page/edit_product_page.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductDto productItem;
  final List<ProductDto> listProduct;
  const ProductItemWidget({
    Key? key,
    required this.productItem,
    required this.listProduct,
  }) : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                imageUrl: widget.productItem.image,
                height: 120,
                width: 120,
                errorWidget: (context, url, error) {
                  return const Icon(Ionicons.image);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productItem.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(widget.productItem.errorDescription),
                  Text(widget.productItem.sku),
                  widget.productItem.color != null
                      ? Text(ConvertColor.convert(widget.productItem.color!))
                      : const Text('---')
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return EditProductPage(
                        productItem: widget.productItem,
                      );
                    }),
                  ).then((result) {
                    if (result != null && result is ProductDto) {
                      widget.productItem.name = result.name;
                      widget.productItem.sku = result.sku;
                      widget.productItem.color = result.color;

                      for (var product in widget.listProduct) {
                        if (result.id == product.id) {
                          product = result;
                        }
                      }
                      setState(() {});
                    }
                  });
                },
                child: const Icon(
                  Icons.edit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
