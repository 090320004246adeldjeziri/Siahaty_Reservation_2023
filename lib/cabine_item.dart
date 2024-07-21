import 'package:cloud_firestore/cloud_firestore.dart';

class CabItem {
  final String prix;
  final String title;
  final List<String> imgUrl;
  final String description;
  final String place;
  final String number;

  CabItem({
    required this.prix,
    required this.title,
    required this.imgUrl,
    required this.description,
    required this.place,
    required this.number,
  });

  factory CabItem.fromJson(Map<String, dynamic> json) {
    return CabItem(
      number: json['number'],
      description: json['description'],
      place: json['place'],
      prix: json['prix'],
      title: json['title'],
      imgUrl: List<String>.from(json['imgUrl']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prix': prix,
      'title': title,
      'imgUrl': imgUrl,
      'description': description,
      'place': place,
      'number': number,
    };
  }
}

List<CabItem> cabins = [];

Future<void> fetchDataFromFirestore() async {
  try {
    // Fetch the data from the 'cabins' collection in Firestore
    final snapshot =
        await FirebaseFirestore.instance.collection('cabins').get();

    // Clear the existing list
    cabins.clear();

    // Iterate over the documents in the snapshot and create CabItem objects
    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      cabins.add(
        CabItem.fromJson(data),
      );
    }
  } on FirebaseException catch (e) {
    // Handle any errors that occurred during the request
    print('Error fetching data from Firestore: $e');
  }
}
