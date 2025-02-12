import 'package:demo_project/product_detail_screen/model/product_detail_model.dart';
import 'package:demo_project/widgets/expansion_tile_widget.dart';
import 'package:demo_project/widgets/html_widget.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Data? productDetails;
  const ProductDetails({super.key, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ExpansionTileWidget(
          title: "Product Description",
          childrens: [
            HtmlWidget(
              htmlString: productDetails?.description ?? "",
            ),
          ],
        ),
        const SizedBox(height: 10),
        ExpansionTileWidget(
          title: "Product Ingredient",
          childrens: [
            HtmlWidget(
              htmlString: productDetails?.ingredient ?? "",
            ),
          ],
        ),
        const SizedBox(height: 10),
        ExpansionTileWidget(
          title: "How To Use?",
          childrens: [
            HtmlWidget(
              htmlString: productDetails?.howToUse ?? "",
            ),
          ],
        ),
      ],
    );
  }
}
