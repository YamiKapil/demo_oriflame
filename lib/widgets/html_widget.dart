import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlWidget extends StatelessWidget {
  final String htmlString;
  const HtmlWidget({
    super.key,
    required this.htmlString,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlString,
      shrinkWrap: true,
      style: {
        "p": Style(
          fontSize: FontSize(12),
          fontWeight: FontWeight.w400,
          fontFamily: "Satoshi",
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
        ),
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
      },
    );
  }
}
