import 'package:demo_project/constants/urls.dart';
import 'package:demo_project/product_detail_screen/model/product_detail_model.dart';
import 'package:demo_project/utils/generic_state.dart';
import 'package:demo_project/utils/network_client.dart';
import 'package:flutter/material.dart';

class ProductDetailController {
  late final ValueNotifier productDetailState;
  final NetworkClient _networkClient = NetworkClient.instance;
  ValueNotifier<int> selectedImageIndex = ValueNotifier<int>(0);
  ValueNotifier<int> selectedVarientIndex = ValueNotifier<int>(0);
  ValueNotifier<int> productQuantity = ValueNotifier<int>(0);

  ProductDetailController._() {
    productDetailState = ValueNotifier<GenericState>(InitialState());
  }
  static final instance = ProductDetailController._();

  Future<void> getProductDetail() async {
    productDetailState.value = LoadingState();
    try {
      await _networkClient.get(Urls.productDetailApi).then((value) {
        var data = ProductDetailModel.fromJson(value.data);
        productDetailState.value =
            LoadedState<ProductDetailModel>(response: data);
      }).onError((e, stackTrace) {
        productDetailState.value = ErrorState(e.toString());
      });
    } catch (e) {
      productDetailState.value = ErrorState(e.toString());
    }
  }

  addProductQuantity() {
    productQuantity.value++;
  }

  subtractProductQuantity() {
    productQuantity.value--;
  }

  setVarientIndex({required int index}) {
    selectedVarientIndex.value = index;
  }

  setImageIndex({required int index}) {
    selectedImageIndex.value = index;
  }
}
