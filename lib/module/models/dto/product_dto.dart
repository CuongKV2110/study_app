import 'package:freezed_annotation/freezed_annotation.dart';
import '../entities/product_entity.dart';
part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto extends ProductEntity {
  @override
  int id;
  @override
  String errorDescription;
  @override
  String name;
  @override
  String sku;
  @override
  String image;
  @override
  int? color;

  bool? isEdited;

  ProductDto({
    required this.id,
    required this.errorDescription,
    required this.name,
    required this.sku,
    required this.image,
    this.color,
    this.isEdited,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
