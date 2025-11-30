import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'seat_page_rio.dart';

class DetailPageSIT extends StatelessWidget {
  final String movieId;
  DetailPageSIT({required this.movieId});

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Film")),
      body: FutureBuilder<DocumentSnapshot>(
        future: db.collection("movies").doc(movieId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Film tidak ditemukan"));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster Film
                if (data['poster_url'] != null)
                  Image.network(
                    data['poster_url'],
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Film
                      Text(
                        data['title'] ?? "",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Harga
                      Text(
                        "Harga: Rp ${data['base_price']}",
                        style: const TextStyle(fontSize: 18),
                      ),

                      const SizedBox(height: 12),

                      // Durasi (opsional)
                      if (data['duration'] != null)
                        Text(
                          "Durasi: ${data['duration']} menit",
                          style: const TextStyle(fontSize: 18),
                        ),

                      const SizedBox(height: 20),

                      // Tombol Book Ticket
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SeatPageRIO(movieId),
                              ),
                            );
                          },
                          child: const Text("Book Ticket"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
