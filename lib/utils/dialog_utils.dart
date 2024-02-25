import 'package:study_app/module/models/dto/product_dto.dart';
import 'package:flutter/material.dart';
import '../page/product_page/product_updated_widget.dart';
import '../widget/app_button.dart';

class DialogUtils {
  static showDialogWithTitleAndOptionButton(
      {required List<ProductDto> data,
      required String content,
      required VoidCallback okButton,
      required BuildContext context}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Stack(
              children: [
                Container(
                  height: 460,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          content,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 360,
                          child: Scrollbar(
                            child: ListView.separated(
                              controller: ScrollController(),
                              itemBuilder: (context, index) {
                                return ProductUpdatedWidget(
                                  productItem: data[index],
                                );
                              },
                              itemCount: data.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 60,
                        child: AppButton(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          backgroundColor: Colors.blue,
                          title: "Ok",
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            okButton();
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static showDialogWithOkButton({
    required BuildContext context,
    required String content,
    required VoidCallback okButton,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 30, left: 30, right: 30, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 60,
                          child: AppButton(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            backgroundColor: Colors.blue,
                            title: "Ok",
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
