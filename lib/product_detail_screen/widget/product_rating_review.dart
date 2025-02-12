import 'package:demo_project/product_detail_screen/model/product_detail_model.dart';
import 'package:demo_project/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class ProductRatingReview extends StatelessWidget {
  final Data productDetail;
  const ProductRatingReview({super.key, required this.productDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              RatingBar.readOnly(
                filledIcon: Icons.star,
                emptyIcon: Icons.star,
                maxRating: 5,
                initialRating:
                    double.tryParse("${productDetail.ratings ?? 0}") ?? 0.0,
                size: 25,
              ),
              const SizedBox(width: 5),
              Text(
                "(${productDetail.ratings}/5.0)",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Rated by: ${productDetail.ratedBy ?? 0}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 10),
          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const AllReviewScreen(),
          //           ),
          //         );
          //       },
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(
          //           vertical: 6,
          //           horizontal: 10,
          //         ),
          //         decoration: BoxDecoration(
          //           border: Border.all(),
          //           borderRadius: BorderRadius.circular(16),
          //         ),
          //         child: const Text(
          //           "See all review",
          //           style: TextStyle(fontSize: 12),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     GestureDetector(
          //       onTap: () {
          //         GeneralBottomSheet.showGeneralBottomSheet(
          //           context,
          //           "Add Review",
          //           child: const ReviewForm(),
          //         );
          //       },
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(
          //           vertical: 6,
          //           horizontal: 10,
          //         ),
          //         decoration: BoxDecoration(
          //           color: ColorConstants.primaryColor,
          //           borderRadius: BorderRadius.circular(16),
          //         ),
          //         child: const Text(
          //           "Write a review",
          //           style: TextStyle(
          //             fontSize: 12,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
