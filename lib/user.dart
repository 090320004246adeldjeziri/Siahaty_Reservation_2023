import 'package:cabina/cabine_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Userx {
  late String name;
  late String email;
  late String phone;
  late String prenom;
  late String username;
  late String img;

  Userx({
    required this.name,
    required this.email,
    required this.phone,
    required this.prenom,
    required this.username,
    required this.img,
  });

  factory Userx.fromJson(Map<String, dynamic> json) {
    return Userx(
      email: json['email'],
      img: json['img'],
      name: json['name'],
      phone: json['phone'],
      prenom: json['prenom'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'img': img,
      'name': name,
      'phone': phone,
      'prenom': prenom,
      'username': username,
    };
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Userx> user = [];

  Future<void> fetchUser() async {
    try {
      // Fetch the data from the 'user' collection in Firestore
      final snapshot = await firestore.collection('users').get();

      // Clear the existing list
      user.clear();

      // Iterate over the documents in the snapshot and create Userx objects
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        user.add(
          Userx.fromJson(data),
        );
      }
    } on FirebaseException catch (e) {
      // Handle any errors that occurred during the request
      print('Error fetching data from Firestore: $e');
    }
  }

  static Future<Userx?> getUserByEmail(String email) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final QuerySnapshot snapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        if (userData != null) {
          return Userx(
            name: userData['name'],
            email: userData['email'],
            phone: userData['phone'],
            prenom: userData['prenom'],
            username: userData['username'],
            img: userData['img'],
          );
        }
      }
    } catch (e) {
      print('Error fetching user: $e');
    }

    return null;
  }
}
