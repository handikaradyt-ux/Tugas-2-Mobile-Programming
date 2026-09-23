class Mahasiswa {
  String nim;
  String nama;
  String prodi;
  int semester;
  double ipk;

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.prodi,
    required this.semester,
    required this.ipk,
  });

  Mahasiswa copyWith({
    String? nim,
    String? nama,
    String? prodi,
    int? semester,
    double? ipk,
  }) {
    return Mahasiswa(
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      prodi: prodi ?? this.prodi,
      semester: semester ?? this.semester,
      ipk: ipk ?? this.ipk,
    );
  }
}
