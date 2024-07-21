import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cabina/user.dart';
import 'package:cabina/profile.dart';
import 'cabine_item.dart';
import 'details_cabine.dart';
import 'list_cabin.dart';
import 'custom_carsoul_slider.dart';

class homeAdd extends StatefulWidget {
  @override
  State<homeAdd> createState() => _homeAddState();
}

class _homeAddState extends State<homeAdd> {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<Userx?> fetchUserByEmail(String email) async {
    Userx? user = await Userx.getUserByEmail(email);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    String x = 'Chercher votre Cabine  ! ';
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(top: 18),
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xbc7087a1),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                  BoxShadow(
                    color: Color(0x3fffffff),
                    blurRadius: 18,
                    offset: Offset(-9, -9),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0x19, 0x33, 0x4B, 1.0),
                    Color.fromRGBO(0x54, 0x6A, 0x83, 1.0),
                  ],
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: FutureBuilder<Userx?>(
                    future: fetchUserByEmail(user?.email ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profile.png"),
                        );
                      } else if (snapshot.hasError) {
                        return const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profile.png"),
                        );
                      } else if (snapshot.hasData) {
                        Userx? user = snapshot.data;
                        if (user != null) {
                          return CircleAvatar(
                            backgroundImage: NetworkImage(user.img),
                          );
                        }
                      }
                      return const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile.png"),
                      );
                    },
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    });
                  },
                  iconSize: 60,
                  hoverColor: Colors.transparent.withOpacity(0),
                ),
                title: FutureBuilder<Userx?>(
                  future: fetchUserByEmail(user?.email ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Chargement...',
                        style: TextStyle(fontFamily: 'Poppins'),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        'Erreur de chargement',
                        style: TextStyle(fontFamily: 'Poppins'),
                      );
                    } else if (snapshot.hasData) {
                      Userx? user = snapshot.data;
                      if (user != null) {
                        return Text(
                          'Bonjour, ${user.name} !',
                          style: TextStyle(fontFamily: 'Poppins'),
                        );
                      }
                    }
                    return const Text(
                      'Bienvenue Ici !',
                      style: TextStyle(fontFamily: 'Poppins'),
                    );
                  },
                ),
                actions: [
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.notifications,
                      ),
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: "Pas de nouvelle",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER_RIGHT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                    hoverColor: Colors.transparent.withOpacity(0),
                    iconSize: 55,
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        transformAlignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 47,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 0.32,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins-Regular",
                                  ),
                                  controller: null,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Poppins-Regular",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    hintText: x,
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    suffixIconColor: Colors.black,
                                    prefixIconColor: Colors.black,
                                    focusColor: Colors.blueAccent[250],
                                    prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: Colors.black),
                                    fillColor: Colors.white,
                                    suffixIcon: const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Recommendations !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromRGBO(210, 219, 234, 80),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: css(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ...cabins
                .map(
                  (CabinItem) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () =>
                          Navigator.of(context, rootNavigator: true).push(
                        CupertinoPageRoute(
                          builder: (_) => CabDet(
                            cabin_item: CabinItem,
                          ),
                        ),
                      ),
                      child: ListItem(cabinItem: CabinItem),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
