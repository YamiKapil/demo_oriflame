import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImages extends StatefulWidget {
  final List<String>? images;
  const ProductImages({
    super.key,
    required this.images,
  });

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: widget.images?[selectedIndex] ?? "",
          imageBuilder: (context, imageProvider) => Container(
            height: 260,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
          placeholder: (BuildContext context, String url) =>
              const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Positioned(
          left: 10,
          top: 20,
          child: Column(
            children: widget.images?.map((e) {
                  final index = widget.images!.indexOf(e);
                  return Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: GestureDetector(
                      onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.images?[index] ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedIndex == index
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (BuildContext context, String url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    );
  }
}
