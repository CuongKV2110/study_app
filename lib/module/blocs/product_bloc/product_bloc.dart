import 'package:study_app/module/models/dto/product_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../repository/abstract_repository/user_repository.dart';
import 'product_state.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductBloc() : super(ProductInitial());
  final userRepository = GetIt.instance.get<UserRepository>();
  List<ProductDto> listProduct = [];
  List<String> listColor = [];

  Future<void> getData() async {
    emit(ProductLoading());
    try {
      final productResponse = await userRepository.getListProduct();
      final colorResponse = await userRepository.getListColor();
      listProduct = productResponse;
      listColor = colorResponse.map((color) => color.name).toList();
      emit(ProductSuccess());
    } catch (e) {
      emit(ProductError());
      rethrow;
    }
  }

  void dispose() {
    close();
  }
}
