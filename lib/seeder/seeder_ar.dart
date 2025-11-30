import 'package:cloud_firestore/cloud_firestore.dart';

class SeederAR {
  final db = FirebaseFirestore.instance;

  Future seedMoviesAR() async {
    await db.collection("movies").doc("mv1").set({
      "title": "Spider Man No Way Home",
      "poster_url": "https://via.placeholder.com/300",
      "base_price": 45000,
      "seat_map": {"A1": "available", "A2": "available", "A3": "sold"},
    });
  }
}
