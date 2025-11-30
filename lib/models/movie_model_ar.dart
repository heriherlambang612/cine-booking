class MovieModelAR {
  final String id;
  final String title;
  final String poster;
  final int price;

  MovieModelAR({
    required this.id,
    required this.title,
    required this.poster,
    required this.price,
  });

  factory MovieModelAR.fromMap(Map<String, dynamic> map, String id) {
    return MovieModelAR(
      id: id,
      title: map['title'],
      poster: map['poster_url'],
      price: map['base_price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "poster_url": poster, "base_price": price};
  }
}
