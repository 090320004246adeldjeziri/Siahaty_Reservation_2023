import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cabine_item.dart';

class CabineDetailsBody extends StatelessWidget {
  final CabItem item_cab;
  CabineDetailsBody({super.key, required this.item_cab});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(15),
          // color: Colors.red,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Renaissance",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            item_cab.place,
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                letterSpacing: 4,
                                fontWeight: FontWeight.w400),
                          ),
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                 
                  child: const Text(
                "Description",
                style: TextStyle(
                    fontFamily: "Poppins", fontWeight: FontWeight.w500),
              )),
              const SizedBox(height: 10),
              Container(
                 
                  padding:
                      const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child:
                      Text(item_cab.description, textAlign: TextAlign.justify)),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Card(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.0),
                          side: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            item_cab.prix,
                            maxLines: null,
                            style: const TextStyle(
                              fontSize: 23.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () => launch(
                            'tel:${item_cab.number}'), // Replace with your desired phone number
                        icon: const Icon(
                          Icons.phone,
                        ),
                        label: Text(item_cab.number),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
