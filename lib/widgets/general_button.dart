import 'package:demo_project/constants/color_constants.dart';
import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPress;
  const GeneralButton({
    super.key,
    required this.buttonText,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primaryColor,
      ),
      onPressed: () {
        onPress?.call();
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
