import 'package:flutter/material.dart';

class ExpansionTileWidget extends StatelessWidget {
  final String title;
  final List<Widget> childrens;
  const ExpansionTileWidget({
    super.key,
    required this.title,
    required this.childrens,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black,width: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      collapsedShape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black,width: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      dense: true,
      // collapsedBackgroundColor: ColorConstants.primaryColor.withOpacity(0.2),
      // backgroundColor: ColorConstants.primaryColor.withOpacity(0.3),
      tilePadding: const EdgeInsets.symmetric(horizontal: 10),
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: childrens,
    );
  }
}
