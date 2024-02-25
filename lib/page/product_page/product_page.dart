import 'package:study_app/page/product_page/product_image_widget.dart';
import 'package:study_app/page/product_page/product_info_widget.dart';
import 'package:study_app/utils/dialog_utils.dart';
import 'package:study_app/utils/singleton.dart';
import 'package:study_app/widget/app_button.dart';
import 'package:study_app/widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/constants.dart';
import '../../module/blocs/product_bloc/product_bloc.dart';
import '../../module/blocs/product_bloc/product_state.dart';
import '../../module/models/dto/product_dto.dart';
import '../../widget/app_loading_overlay.dart';
import '../edit_product_page/edit_product_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductBloc _bloc = ProductBloc();
  List<ProductDto> listProduct = [];
  List<ProductDto> currentProducts = [];
  final ScrollController _controller = ScrollController();
  int currentPage = 0;
  bool isInitialLoad = false;
  bool isEndOfData = false;

  @override
  void initState() {
    super.initState();
    _bloc.getData();
    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          currentPage < (listProduct.length / 10).ceil()) {
        currentPage += 1;
        int startIndex = 10 * (currentPage);
        int endIndex = startIndex + 10;
        if (startIndex < listProduct.length) {
          int endLimit =
              endIndex < listProduct.length ? endIndex : listProduct.length - 1;
          for (int i = startIndex; i < endLimit; i++) {
            currentProducts.add(listProduct[i]);
          }
          if (endIndex >= listProduct.length) {
            isEndOfData = true;
          }
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhiteF0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarWidget(title: 'Products'),
          body: BlocProvider<ProductBloc>.value(
            value: _bloc,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductSuccess) {
                  _initListProduct();
                  Singleton.instance.listColor = _bloc.listColor;
                  return _buildBodySuccess();
                } else if (state is ProductSuccess) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else {
                  return const AppLoadingOverlay(
                    isLoading: true,
                    child: SizedBox(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildBodySuccess() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Column(
        children: [
          _buildProductList(),
          _submitButton(),
        ],
      ),
    );
  }

  _initListProduct() {
    if (isInitialLoad == false) {
      listProduct = _bloc.listProduct;
      int startIndex = 10 * (currentPage);
      int endIndex = startIndex + 10;
      int endLimit =
          endIndex < listProduct.length ? endIndex : listProduct.length - 1;
      for (int i = startIndex; i < endLimit; i++) {
        currentProducts.add(listProduct[i]);
      }
      isInitialLoad = true;
    }
  }

  _buildProductList() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        controller: _controller,
        itemBuilder: (context, index) {
          if (index < currentProducts.length - 1) {
            return _productItemWidget(currentProducts[index], index);
          } else {
            return isEndOfData == true
                ? const SizedBox()
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Spacer(),
                        CircularProgressIndicator(),
                        Spacer(),
                      ],
                    ),
                  );
          }
        },
        separatorBuilder: (context, index) {
          return hSpaceItem1;
        },
        itemCount: currentProducts.length,
      ),
    );
  }

  _submitButton() {
    return AppButton(
      buttonHeight: 60,
      backgroundColor: Colors.blue,
      title: 'SUBMIT',
      onTap: () {
        _onSubmit();
      },
    );
  }

  _productItemWidget(ProductDto productItem, int index) {
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
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ProductImageWidget(imgUrl: productItem.image),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: ProductInfoWidget(productItem: productItem),
            ),
            wSpaceItem,
            _editIconWidget(productItem),
          ],
        ),
      ),
    );
  }

  _editIconWidget(ProductDto productItem) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return EditProductPage(
              productItem: productItem,
            );
          }),
        ).then((result) {
          if (result != null && result is ProductDto) {
            productItem = result;
            for (int i = 0; i < currentProducts.length; i++) {
              if (result.id == currentProducts[i].id) {
                currentProducts[i] = result;
                break;
              }
            }
            setState(() {});
          }
        });
      },
      child: const Icon(
        Icons.edit,
      ),
    );
  }

  _onSubmit() {
    if (currentProducts.any((product) => product.isEdited == true)) {
      DialogUtils.showDialogWithTitleAndOptionButton(
        data: currentProducts
            .where((product) => product.isEdited == true)
            .toList(),
        content: 'Submit Changes',
        okButton: () {},
        context: context,
      );
    } else {
      DialogUtils.showDialogWithOkButton(
          context: context,
          content: 'No products have been edited yet',
          okButton: () {});
    }
  }
}
