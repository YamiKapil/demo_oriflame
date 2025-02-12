import 'package:demo_project/constants/color_constants.dart';
import 'package:demo_project/widgets/general_button.dart';
import 'package:demo_project/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final TextEditingController comment = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController ratingController =
      TextEditingController(text: '0');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    comment.dispose();
    name.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Full Name",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                // labelText: "Message",
                // hintText: "Please enter your message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: ColorConstants.primaryColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Field cannot be empty";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            const Text(
              "Rate the product",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            RatingBar(
              filledIcon: Icons.star,
              emptyIcon: Icons.star,
              maxRating: 5,
              initialRating: double.tryParse(ratingController.text) ?? 0.0,
              size: 25,
              onRatingChanged: (rating) {
                ratingController.text = rating.toString();
              },
            ),
            const SizedBox(height: 10),
            const Text(
              "Comment",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: comment,
              decoration: InputDecoration(
                // labelText: "Message",
                // hintText: "Please enter your message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: ColorConstants.primaryColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Field cannot be empty";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: GeneralButton(
                buttonText: "Send Review",
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    var snackBar = const SnackBar(
                      content: Text('Successfully reviewd'),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
