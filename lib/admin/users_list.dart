import 'package:cabina/admin/screenChoice.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 45,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.to(ChoiceScreen()),
          ) // Navigate to the correct route name
          ,
          title: Text('Liste Users'), // Set the title for the page
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: usersCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                String username = document['username'];
                String profilePictureUrl = document['img'];
                String documentId = document.id;

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(profilePictureUrl),
                    ),
                    title: Text(username),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteUser(documentId);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteUser(String documentId) async {
    try {
      await usersCollection.doc(documentId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      // Handle the error as needed
    }
  }
}
