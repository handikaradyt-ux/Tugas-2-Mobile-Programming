class Barang {
  String kode;
  String nama;
  int stok;
  double harga;

  Barang({
    required this.kode,
    required this.nama,
    required this.stok,
    required this.harga,
  });

  /// Nilai setiap barang = stok * harga
  double get nilaiTotal => stok * harga;

  Barang copyWith({
    String? kode,
    String? nama,
    int? stok,
    double? harga,
  }) {
    return Barang(
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      stok: stok ?? this.stok,
      harga: harga ?? this.harga,
    );
  }
}
