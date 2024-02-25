import 'package:study_app/module/models/dto/color_dto.dart';

import '../../module/models/dto/product_dto.dart';
import 'base_api_service.dart';

class UserService extends BaseApiService {
  Future<List<ProductDto>> getListProduct() async {
    try {
      final response = await dio.get('products');
      if (response.data is List) {
        final List<dynamic> data = response.data;
        List<ProductDto> listMenu =
            data.map((e) => ProductDto.fromJson(e)).toList();
        return listMenu;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ColorDto>> getListColor() async {
    try {
      final response = await dio.get('colors');
      if (response.data is List) {
        final List<dynamic> data = response.data;
        List<ColorDto> listColor =
            data.map((e) => ColorDto.fromJson(e)).toList();
        return listColor;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
