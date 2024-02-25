// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
      id: json['id'] as int,
      errorDescription: json['errorDescription'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      image: json['image'] as String,
      color: json['color'] as int?,
      isEdited: json['isEdited'] as bool?,
    );

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'errorDescription': instance.errorDescription,
      'name': instance.name,
      'sku': instance.sku,
      'image': instance.image,
      'color': instance.color,
      'isEdited': instance.isEdited,
    };
