import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageSIT extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Film")),
      body: StreamBuilder(
        stream: db.collection("movies").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['title']),
                subtitle: Text("Rp ${doc['base_price']}"),
                onTap: () {
                  Navigator.pushNamed(context, '/seat', arguments: doc.id);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
