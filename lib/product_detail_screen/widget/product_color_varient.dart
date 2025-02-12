import 'package:demo_project/product_detail_screen/controller/product_detail_controller.dart';
import 'package:demo_project/product_detail_screen/model/product_detail_model.dart';
import 'package:demo_project/utils/hex_color_converter.dart';
import 'package:flutter/material.dart';

class ProductColorVarient extends StatefulWidget {
  final List<ColorVariants>? colorVarient;
  final Data? productDetails;
  const ProductColorVarient({
    super.key,
    required this.colorVarient,
    required this.productDetails,
  });

  @override
  State<ProductColorVarient> createState() => _ProductColorVarientState();
}

class _ProductColorVarientState extends State<ProductColorVarient> {
  final ProductDetailController productDetailController =
      ProductDetailController.instance;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: productDetailController.selectedVarientIndex,
        builder: (context, varientIndex, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.productDetails?.brand?.name ?? "",
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.productDetails?.title ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (widget.colorVarient?[varientIndex].maxOrder != null &&
                      widget.colorVarient?[varientIndex].maxOrder != 0)
                    Text(
                      "(In Stock: ${widget.colorVarient?[varientIndex].maxOrder ?? ""})",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    const Text(
                      "(Out of Stock)",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Rs.",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    TextSpan(
                      text:
                          "${widget.colorVarient?[varientIndex].price ?? 0.0}  ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(
                      text: "Rs.",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    TextSpan(
                      text:
                          "${widget.colorVarient?[varientIndex].strikePrice ?? 0.0}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(
                      text:
                          "  ${widget.colorVarient?[varientIndex].offPercent ?? 0.0}% OFF ",
                      style:
                          const TextStyle(color: Colors.orange, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Row(
              //   children: [
              //     const Icon(Icons.star_rounded, color: Colors.orange),
              //     const SizedBox(width: 5),
              //     Text(
              //       "${widget.productDetails?.totalRatings ?? 0.0}",
              //       style: const TextStyle(
              //         fontSize: 14,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     const SizedBox(width: 5),
              //     const Text(
              //       "Ratings",
              //       style: TextStyle(
              //         fontSize: 14,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     const SizedBox(width: 5),
              //     const Text(
              //       "|",
              //       style: TextStyle(
              //         fontSize: 14,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     const SizedBox(width: 5),
              //     Text(
              //       widget.productDetails?.variantType ?? "",
              //       style: const TextStyle(
              //         fontSize: 14,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     const SizedBox(width: 5),
              //     const Text(
              //       "|",
              //       style: TextStyle(
              //         fontSize: 14,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     const SizedBox(width: 5),
              //   ],
              // ),
              const SizedBox(height: 5),
              Text(
                "${widget.productDetails?.variantType ?? ""} (${widget.colorVarient?[varientIndex].color?.name ?? ""})",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: widget.colorVarient?.map((e) {
                      final index = widget.colorVarient!.indexOf(e);
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            productDetailController.setVarientIndex(
                              index: index,
                            );
                            if (productDetailController.productQuantity.value >
                                (widget.colorVarient?[index].maxOrder ?? 0)) {
                              productDetailController.productQuantity.value =
                                  widget.colorVarient?[index].maxOrder ?? 0;
                            }
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: varientIndex == index
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                              shape: BoxShape.circle,
                              color: HexColorConverter.fromHex(
                                e.color?.colorValue?.first ?? "",
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ],
          );
        });
  }
}
