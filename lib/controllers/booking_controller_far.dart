int hitungHargaFAR(String title, int basePrice, List<String> seats) {
  int total = 0;

  if (title.length > 10) {
    total += 2500 * seats.length;
  }

  for (var seat in seats) {
    int nomor = int.parse(seat.substring(1));
    int price = basePrice;

    if (nomor % 2 == 0) {
      price = (price * 0.9).toInt();
    }

    total += price;
  }

  return total;
}
