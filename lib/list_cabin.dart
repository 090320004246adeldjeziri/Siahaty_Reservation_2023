import 'package:flutter/material.dart';

import 'cabine_item.dart';

class ListItem extends StatelessWidget {
  final CabItem cabinItem;
  ListItem({
    Key? key,
    required this.cabinItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            cabinItem.imgUrl[0],
            height: 80,
            width: 140,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 30.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cabinItem.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              cabinItem.prix.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black, debugLabel: "Prix !"),
            ),
          ],
        )
      ],
    );
  }
}
