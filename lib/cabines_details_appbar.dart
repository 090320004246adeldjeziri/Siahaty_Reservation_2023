import 'package:cabina/cabine_item.dart';
import 'package:cabina/gallery.dart';
import 'package:cabina/list_cabin.dart';
import 'package:cabina/saved_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'details_cabine.dart';

class CabinesDetailsAppBar extends StatelessWidget {
  final CabItem item_cab;
  const CabinesDetailsAppBar({super.key, required this.item_cab});

  @override
  Widget build(BuildContext context) {
    void openGallery() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GalleryWidget(
                index: 0,
                urlImg: item_cab.imgUrl,
              )));
    }

    final size = MediaQuery.of(context).size;
    return SliverAppBar(
        expandedHeight: size.height * 0.30,
        //leading: Icon(Icons.arrow_back),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .push(CupertinoPageRoute(builder: (_) => SavedScreen())),
              icon: const Icon(
                Icons.save,
              ))
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  // decoration: BoxDecoration(borderRadius: BorderRadius.only()),
                  child: InkWell(
                    onTap: openGallery,
                    child: Ink.image(
                      image: NetworkImage(item_cab.imgUrl[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          stretchModes: const [
            StretchMode.blurBackground,
            StretchMode.zoomBackground,
          ],
        ),
        pinned: true,
        collapsedHeight: size.height * 0.1,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              height: size.height * 0.07,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
            )));
  }
}
