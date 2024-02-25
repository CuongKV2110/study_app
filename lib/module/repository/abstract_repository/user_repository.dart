import 'package:study_app/module/models/dto/color_dto.dart';
import '../../models/dto/product_dto.dart';

abstract class UserRepository {
  Future<List<ProductDto>> getListProduct();

  Future<List<ColorDto>> getListColor();
}
