import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryWidget extends StatefulWidget {
  GalleryWidget({super.key, required this.urlImg, required this.index})
      : pc = PageController(initialPage: index);
  final PageController pc;
  final List<String> urlImg;
  final int index;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PhotoViewGallery.builder(
            itemCount: widget.urlImg.length,
            builder: (context, index) {
              final urlImg = widget.urlImg[index];
              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(urlImg),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4);
            }));
  }
}
