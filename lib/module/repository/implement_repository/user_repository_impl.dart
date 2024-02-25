import 'package:study_app/module/models/dto/color_dto.dart';
import '../../../service/api/user_service.dart';
import '../../models/dto/product_dto.dart';
import '../abstract_repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final userService = UserService();

  @override
  Future<List<ProductDto>> getListProduct() {
    return userService.getListProduct();
  }

  @override
  Future<List<ColorDto>> getListColor() {
    return userService.getListColor();
  }
}
