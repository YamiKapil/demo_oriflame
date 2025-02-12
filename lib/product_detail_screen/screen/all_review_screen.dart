import 'package:demo_project/constants/color_constants.dart';
import 'package:demo_project/product_detail_screen/widget/review_form.dart';
import 'package:demo_project/widgets/general_bottomsheet.dart';
import 'package:flutter/material.dart';

class AllReviewScreen extends StatelessWidget {
  const AllReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Review",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: ColorConstants.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text(
          "No reviews found!",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          GeneralBottomSheet.showGeneralBottomSheet(
            context,
            "Add Review",
            child: const ReviewForm(),
          );
        },
        backgroundColor: ColorConstants.primaryColor,
        child: const Icon(
          Icons.rate_review_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
