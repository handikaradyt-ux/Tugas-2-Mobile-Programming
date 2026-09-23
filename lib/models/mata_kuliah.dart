class MataKuliah {
  String kode;
  String nama;
  int sks;
  String dosen;

  MataKuliah({
    required this.kode,
    required this.nama,
    required this.sks,
    required this.dosen,
  });

  MataKuliah copyWith({
    String? kode,
    String? nama,
    int? sks,
    String? dosen,
  }) {
    return MataKuliah(
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      sks: sks ?? this.sks,
      dosen: dosen ?? this.dosen,
    );
  }
}
