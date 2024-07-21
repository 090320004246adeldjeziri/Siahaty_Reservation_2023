import 'package:flutter/material.dart';
import 'cabine_details_body.dart';
import 'cabine_item.dart';
import 'cabines_details_appbar.dart';
import 'custom_carsoul_slider.dart';

class CabDet extends StatelessWidget {
  final CabItem cabin_item;

  CabDet({super.key, required this.cabin_item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CabinesDetailsAppBar(
            item_cab: cabin_item,
          ),
          SliverToBoxAdapter(
            child: CabineDetailsBody(
              item_cab: cabin_item,
            ),
          )
        ],
      ),
    );
  }
}
