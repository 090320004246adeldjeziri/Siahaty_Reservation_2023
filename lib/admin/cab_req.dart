import 'package:cloud_firestore/cloud_firestore.dart';

class ReqItemCab {
  final String prix;
  final String title;
  final List<String> imgUrl;
  final String description;
  final String place;
  final String number;

  ReqItemCab({
    required this.prix,
    required this.title,
    required this.imgUrl,
    required this.description,
    required this.place,
    required this.number,
  });

  factory ReqItemCab.fromJson(Map<String, dynamic> json) {
    return ReqItemCab(
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

List<ReqItemCab> cabinsreq = [];

Future<void> fetchDataFromFirestoreReq() async {
  try {
    final snapshot =
        await FirebaseFirestore.instance.collection('cabinsreq').get();
    cabinsreq.clear();

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      cabinsreq.add(ReqItemCab.fromJson(data));
    }
  } on FirebaseException catch (e) {
    print('Error cant feth data from firestore $e');
  }
}
