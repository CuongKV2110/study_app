import 'package:study_app/page/edit_product_page/image_product_widget.dart';
import 'package:study_app/utils/convert_color.dart';
import 'package:study_app/utils/dialog_utils.dart';
import 'package:study_app/utils/singleton.dart';
import 'package:study_app/widget/app_button.dart';
import 'package:study_app/widget/app_input.dart';
import 'package:study_app/widget/keyboard_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/constants.dart';
import '../../module/models/dto/product_dto.dart';
import '../../widget/appbar_widget.dart';

class EditProductPage extends StatefulWidget {
  final ProductDto productItem;
  const EditProductPage({Key? key, required this.productItem})
      : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> listColor = [];
  @override
  void initState() {
    super.initState();
    productNameController.text = widget.productItem.name;
    skuController.text = widget.productItem.sku;
    if (widget.productItem.color == null) {
      colorController.text = '';
    } else {
      colorController.text = ConvertColor.convert(widget.productItem.color!);
    }

    listColor = Singleton().listColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhiteF0,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhiteF0,
          appBar: AppBarWidget(
            title: 'Edit Product',
            leadingWidget: const BackButton(),
          ),
          body: WKeyboardDismiss(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageProductWidget(imgUrl: widget.productItem.image),
                    Text(widget.productItem.errorDescription),
                    _editForm(),
                    hSpaceItem2,
                    _optionsButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _optionsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: SizedBox(
            width: 100,
            height: 40,
            child: AppButton(
              borderRaius: 22,
              buttonHeight: 46,
              backgroundColor: Colors.grey,
              title: 'Cancel',
              onTap: () {
                _onCancel();
              },
            ),
          ),
        ),
        wSpaceItem2,
        Expanded(
          child: SizedBox(
            width: 100,
            height: 40,
            child: AppButton(
              borderRaius: 22,
              backgroundColor: Colors.blue,
              title: 'Save',
              onTap: () {
                _onSubmit();
              },
            ),
          ),
        ),
      ],
    );
  }

  _editForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppInput(
            fillColor: colorGray83,
            title: 'Product Name',
            controller: productNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ProductName is required';
              }
              if (value.length > 50) {
                return 'Product name cannot be more than 50 characters';
              }
              return null;
            },
            textInputFormatters: [
              LengthLimitingTextInputFormatter(500),
            ],
          ),
          hSpaceItem1,
          AppInput(
            fillColor: colorGray83,
            title: 'SKU',
            controller: skuController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'SKU is required';
              }
              if (value.length > 20) {
                return 'SKU cannot be more than 20 characters';
              }
              return null;
            },
            textInputFormatters: [
              LengthLimitingTextInputFormatter(200),
            ],
          ),
          hSpaceItem1,
          const Text(
            'Color',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          hSpaceItem,
          DropdownMenu<String>(
            width: 120,
            initialSelection: widget.productItem.color == null
                ? listColor.first
                : ConvertColor.convert(widget.productItem.color!),
            controller: colorController,
            requestFocusOnTap: true,
            onSelected: (String? color) {
              widget.productItem.color = ConvertColor.parseColor(color!);
            },
            dropdownMenuEntries:
                listColor.map<DropdownMenuEntry<String>>((String color) {
              return DropdownMenuEntry<String>(
                value: color,
                label: color,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  _onSubmit() {
    if ((_formKey.currentState?.validate() ?? false)) {
      if (productNameController.text == widget.productItem.name &&
          skuController.text == widget.productItem.sku &&
          ConvertColor.parseColor(colorController.text) ==
              widget.productItem.color) {
        Navigator.pop(context);
      } else {
        ProductDto productEdited = ProductDto(
          id: widget.productItem.id,
          errorDescription: widget.productItem.errorDescription,
          name: productNameController.text,
          sku: skuController.text,
          image: widget.productItem.image,
          color: ConvertColor.parseColor(colorController.text),
          isEdited: true,
        );
        Navigator.pop(context, productEdited);
      }
    }
  }

  _onCancel() {
    productNameController.text = widget.productItem.name;
    skuController.text = widget.productItem.sku;
    if (widget.productItem.color == null) {
      colorController.text = listColor.first;
    } else {
      colorController.text = ConvertColor.convert(widget.productItem.color!);
    }
    setState(() {});
    Navigator.of(context).pop();
  }
}
