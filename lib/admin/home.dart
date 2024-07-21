import 'package:cabina/admin/screenChoice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../cabine_item.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Future<void> _deleteCabin(String documentId, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('cabinsreq')
          .doc("1L5kbCWakjYRA5eCQegM")
          .delete();
      setState(() {
        cabins.removeAt(index);
      });
    } catch (e) {
      print('Error deleting cabin: $e');
      // Handle the error as needed
    }
  }

  Future<void> _confirmDelete(CabItem cabin, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this cabin?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteCabin(cabin.number, index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 45,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.to(ChoiceScreen());
          },
        ),
        title: Text('Liste Cabine'),
      ),
      body: FutureBuilder<void>(
        future: fetchDataFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data from Firestore'));
          } else {
            return ListView.builder(
              itemCount: cabins.length,
              itemBuilder: (context, index) {
                final cabin = cabins[index];
                return Container(
                  height: 150,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          cabin.imgUrl.first,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cabin.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Price: ${cabin.prix}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _confirmDelete(cabin, index),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
