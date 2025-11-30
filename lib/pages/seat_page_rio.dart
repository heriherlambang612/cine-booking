import 'package:flutter/material.dart';

class SeatPageRIO extends StatefulWidget {
  final String movieId;
  SeatPageRIO(this.movieId);

  @override
  State<SeatPageRIO> createState() => _SeatPageRIOState();
}

class _SeatPageRIOState extends State<SeatPageRIO> {
  List<String> selected = [];

  void toggle(String seat) {
    setState(() {
      if (selected.contains(seat))
        selected.remove(seat);
      else
        selected.add(seat);
    });
  }

  @override
  Widget build(BuildContext context) {
    final seats = ["A1", "A2", "A3", "A4"];

    return Scaffold(
      appBar: AppBar(title: Text("Pilih Kursi")),
      body: Wrap(
        children: seats.map((s) {
          return GestureDetector(
            onTap: () => toggle(s),
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              color: selected.contains(s) ? Colors.blue : Colors.grey,
              child: Text(s),
            ),
          );
        }).toList(),
      ),
    );
  }
}
