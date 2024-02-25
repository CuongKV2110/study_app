import 'package:freezed_annotation/freezed_annotation.dart';
import '../entities/color_entity.dart';
part 'color_dto.g.dart';

@JsonSerializable()
class ColorDto extends ColorEntity {
  @override
  int id;
  @override
  String name;

  ColorDto({
    required this.id,
    required this.name,
  });

  factory ColorDto.fromJson(Map<String, dynamic> json) =>
      _$ColorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ColorDtoToJson(this);
}
