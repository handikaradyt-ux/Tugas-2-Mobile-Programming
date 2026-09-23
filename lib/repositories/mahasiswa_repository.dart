import '../models/mahasiswa.dart';

/// Kontrak Repository Mahasiswa (Bagian V LKM)
/// Antarmuka ini memisahkan logika data dari UI Flutter.
/// Di masa mendatang, implementasi berbasis List lokal ini dapat digantikan
/// oleh implementasi SQLite/Hive atau REST API tanpa mengubah kode antarmuka UI.
abstract class MahasiswaRepository {
  List<Mahasiswa> getAll();
  void add(Mahasiswa mahasiswa);
  void update(Mahasiswa mahasiswa, {String? oldNim});
  void delete(Mahasiswa mahasiswa);
  bool existsNim(String nim, {String? excludeNim});
  List<Mahasiswa> getFilteredAndSorted({
    String keyword = '',
    String filterIpk = 'Semua',
    String sortBy = 'Nama A-Z',
  });
}

/// Implementasi Repository berbasis Koleksi List Lokal (In-Memory)
class InMemoryMahasiswaRepository implements MahasiswaRepository {
  final List<Mahasiswa> _dataMahasiswa = [
    Mahasiswa(
      nim: '23010001',
      nama: 'Ahmad Fauzi',
      prodi: 'Teknik Informatika',
      semester: 5,
      ipk: 3.75,
    ),
    Mahasiswa(
      nim: '23010002',
      nama: 'Budi Santoso',
      prodi: 'Teknik Informatika',
      semester: 3,
      ipk: 3.20,
    ),
    Mahasiswa(
      nim: '23010003',
      nama: 'Citra Lestari',
      prodi: 'Sistem Informasi',
      semester: 5,
      ipk: 3.85,
    ),
    Mahasiswa(
      nim: '23010004',
      nama: 'Dewi Maharani',
      prodi: 'Teknik Informatika',
      semester: 1,
      ipk: 3.40,
    ),
    Mahasiswa(
      nim: '23010005',
      nama: 'Eka Saputra',
      prodi: 'Sistem Informasi',
      semester: 7,
      ipk: 3.65,
    ),
    Mahasiswa(
      nim: '23010006',
      nama: 'Farhan Hidayat',
      prodi: 'Teknik Komputer',
      semester: 3,
      ipk: 3.10,
    ),
  ];

  @override
  List<Mahasiswa> getAll() {
    return List.unmodifiable(_dataMahasiswa);
  }

  @override
  void add(Mahasiswa mahasiswa) {
    _dataMahasiswa.add(mahasiswa);
  }

  @override
  void update(Mahasiswa mahasiswa, {String? oldNim}) {
    final targetNim = (oldNim != null && oldNim.isNotEmpty) ? oldNim : mahasiswa.nim;
    final index = _dataMahasiswa.indexWhere(
      (m) => m.nim.toLowerCase() == targetNim.toLowerCase(),
    );
    if (index != -1) {
      _dataMahasiswa[index] = mahasiswa;
    }
  }

  @override
  void delete(Mahasiswa mahasiswa) {
    _dataMahasiswa.removeWhere((m) => m.nim == mahasiswa.nim);
  }

  @override
  bool existsNim(String nim, {String? excludeNim}) {
    return _dataMahasiswa.any(
      (m) => m.nim.toLowerCase() == nim.toLowerCase() && m.nim != excludeNim,
    );
  }

  @override
  List<Mahasiswa> getFilteredAndSorted({
    String keyword = '',
    String filterIpk = 'Semua',
    String sortBy = 'Nama A-Z',
  }) {
    // 1. Salin data sumber
    List<Mahasiswa> hasil = List<Mahasiswa>.from(_dataMahasiswa);

    // 2. Pencarian (Search) dengan where() multi-atribut
    if (keyword.trim().isNotEmpty) {
      final q = keyword.toLowerCase().trim();
      hasil = hasil.where((mhs) {
        return mhs.nama.toLowerCase().contains(q) ||
            mhs.nim.toLowerCase().contains(q) ||
            mhs.prodi.toLowerCase().contains(q) ||
            mhs.semester.toString().contains(q);
      }).toList();
    }

    // 3. Filter IPK dengan where()
    if (filterIpk == 'IPK ≥ 3.50') {
      hasil = hasil.where((mhs) => mhs.ipk >= 3.50).toList();
    } else if (filterIpk == 'IPK < 3.50') {
      hasil = hasil.where((mhs) => mhs.ipk < 3.50).toList();
    }

    // 4. Sorting (Pengurutan)
    switch (sortBy) {
      case 'Nama A-Z':
        hasil.sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
        break;
      case 'Nama Z-A':
        hasil.sort((a, b) => b.nama.toLowerCase().compareTo(a.nama.toLowerCase()));
        break;
      case 'IPK Tertinggi':
        hasil.sort((a, b) => b.ipk.compareTo(a.ipk));
        break;
      case 'IPK Terendah':
        hasil.sort((a, b) => a.ipk.compareTo(b.ipk));
        break;
      case 'Semester':
        hasil.sort((a, b) => a.semester.compareTo(b.semester));
        break;
      default:
        hasil.sort((a, b) => a.nama.compareTo(b.nama));
    }

    return hasil;
  }
}
