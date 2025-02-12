import 'package:demo_project/constants/color_constants.dart';
import 'package:demo_project/product_detail_screen/controller/product_detail_controller.dart';
import 'package:demo_project/product_detail_screen/model/product_detail_model.dart';
import 'package:demo_project/product_detail_screen/screen/all_review_screen.dart';
import 'package:demo_project/product_detail_screen/widget/contact_seller_form.dart';
import 'package:demo_project/product_detail_screen/widget/product_color_varient.dart';
import 'package:demo_project/product_detail_screen/widget/product_details.dart';
import 'package:demo_project/product_detail_screen/widget/product_images.dart';
import 'package:demo_project/product_detail_screen/widget/product_rating_review.dart';
import 'package:demo_project/utils/generic_state.dart';
import 'package:demo_project/widgets/general_bottomsheet.dart';
import 'package:demo_project/widgets/general_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailController _productDetailController =
      ProductDetailController.instance;
  @override
  void initState() {
    super.initState();
    _productDetailController.getProductDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Detail",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ValueListenableBuilder(
              valueListenable: _productDetailController.productQuantity,
              builder: (context, quantity, _) {
                if (quantity == 0) {
                  return const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  );
                } else {
                  return Badge.count(
                    count: quantity,
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
          ),
        ],
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10,
        ),
        child: ValueListenableBuilder(
            valueListenable: _productDetailController.productDetailState,
            builder: (context, value, _) {
              switch (value) {
                case LoadingState():
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ErrorState():
                  return Center(
                    child: Text(value.exception.toString()),
                  );
                case LoadedState<ProductDetailModel>():
                  if (value.response != null && value.response?.data != null) {
                    Data productData = value.response!.data!;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ProductImages(
                            images: productData.images,
                          ),
                          const SizedBox(height: 10),
                          ProductColorVarient(
                            colorVarient: productData.colorVariants,
                            productDetails: productData,
                          ),
                          // const SizedBox(height: 10),
                          ProductRatingReview(
                            productDetail: productData,
                          ),
                          const SizedBox(height: 10),
                          ProductDetails(productDetails: productData),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Couldnot find product detail"),
                    );
                  }
                default:
                  return Container();
              }
            }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   shape: const CircleBorder(),
      //   onPressed: () async {
      //     GeneralBottomSheet.showGeneralBottomSheet(
      //       context,
      //       "Message seller",
      //       child: const ContactSellerForm(),
      //     );
      //   },
      //   backgroundColor: ColorConstants.primaryColor,
      //   child: const Icon(
      //     Icons.chat,
      //     color: Colors.white,
      //   ),
      // ),
      bottomNavigationBar: AnimatedBuilder(
          animation: Listenable.merge([
            _productDetailController.productQuantity,
            _productDetailController.productDetailState,
            _productDetailController.selectedVarientIndex,
          ]),
          builder: (context, _) {
            if (_productDetailController.productDetailState.value
                is! LoadedState) {
              return const SizedBox.shrink();
            }
            final productDetailData = (_productDetailController
                    .productDetailState.value as LoadedState<ProductDetailModel>)
                .response
                ?.data;
            final productQuantity =
                _productDetailController.productQuantity.value;
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10,
              ),
              child: Row(
                children: [
                  if (productQuantity == 0 &&
                      ((productDetailData
                                  ?.colorVariants?[_productDetailController
                                      .selectedVarientIndex.value]
                                  .maxOrder ??
                              0) >
                          productQuantity))
                    Expanded(
                      child: GeneralButton(
                        buttonText: "Add to Cart",
                        onPress: () {
                          _productDetailController.addProductQuantity();
                        },
                      ),
                    )
                  else ...[
                    GestureDetector(
                      onTap: () {
                        _productDetailController.subtractProductQuantity();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      productQuantity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        if ((productDetailData
                                    ?.colorVariants?[_productDetailController
                                        .selectedVarientIndex.value]
                                    .maxOrder ??
                                0) >
                            productQuantity) {
                          _productDetailController.addProductQuantity();
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ((productDetailData
                                          ?.colorVariants?[
                                              _productDetailController
                                                  .selectedVarientIndex.value]
                                          .maxOrder ??
                                      0) >
                                  _productDetailController
                                      .productQuantity.value)
                              ? ColorConstants.primaryColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GeneralButton(
                      buttonText: "Checkout",
                      onPress: () {},
                    ),
                  ],
                ],
              ),
            );
          }),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: _productDetailController.productDetailState,
          builder: (context, state, _) {
            if (state is! LoadedState) return const SizedBox.shrink();
            return SpeedDial(
              backgroundColor: ColorConstants.primaryColor,
              spaceBetweenChildren: 10,
              renderOverlay: true,
              icon: Icons.info_outline_rounded,
              iconTheme: const IconThemeData(color: Colors.white),
              useRotationAnimation: true,
              activeChild: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              children: [
                SpeedDialChild(
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.rate_review_sharp,
                    color: Colors.white,
                  ),
                  backgroundColor: ColorConstants.primaryColor,
                  label: 'Review',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllReviewScreen(),
                      ),
                    );
                  },
                ),
                SpeedDialChild(
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.chat_rounded,
                    color: Colors.white,
                  ),
                  backgroundColor: ColorConstants.primaryColor,
                  label: 'Message Seller',
                  onTap: () {
                    GeneralBottomSheet.showGeneralBottomSheet(
                      context,
                      "Message Seller",
                      child: const ContactSellerForm(),
                    );
                  },
                ),
              ],
            );
          }),
    );
  }
}
