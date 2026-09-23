import '../models/mata_kuliah.dart';

/// Kontrak Repository Mata Kuliah (Studi Kasus J LKM & Challenge)
abstract class MataKuliahRepository {
  List<MataKuliah> getAll();
  void add(MataKuliah mataKuliah);
  void update(MataKuliah mataKuliah, {String? oldKode});
  void delete(MataKuliah mataKuliah);
  bool existsKode(String kode, {String? excludeKode});
  List<MataKuliah> getFilteredAndSorted({
    String keyword = '',
    String filterSks = 'Semua',
    String sortBy = 'Nama A-Z',
  });
}

/// Implementasi Repository Mata Kuliah berbasis In-Memory List
class InMemoryMataKuliahRepository implements MataKuliahRepository {
  final List<MataKuliah> _dataMataKuliah = [
    MataKuliah(
      kode: 'IF2101',
      nama: 'Pemrograman Mobile',
      sks: 3,
      dosen: 'Dr. Ir. Budi Raharjo',
    ),
    MataKuliah(
      kode: 'IF2102',
      nama: 'Struktur Data & Algoritma',
      sks: 4,
      dosen: 'Siti Aminah, M.Kom.',
    ),
    MataKuliah(
      kode: 'IF2103',
      nama: 'Basis Data Lanjut',
      sks: 3,
      dosen: 'Agus Setiawan, M.T.',
    ),
    MataKuliah(
      kode: 'IF2104',
      nama: 'Etika Profesi IT',
      sks: 2,
      dosen: 'Rina Marlina, M.Hum.',
    ),
    MataKuliah(
      kode: 'IF2105',
      nama: 'Rekayasa Perangkat Lunak',
      sks: 3,
      dosen: 'Hendra Wijaya, M.Sc.',
    ),
    MataKuliah(
      kode: 'IF2106',
      nama: 'Desain Antarmuka Pengguna (UI/UX)',
      sks: 2,
      dosen: 'Maya Sari, M.Ds.',
    ),
  ];

  @override
  List<MataKuliah> getAll() {
    return List.unmodifiable(_dataMataKuliah);
  }

  @override
  void add(MataKuliah mataKuliah) {
    _dataMataKuliah.add(mataKuliah);
  }

  @override
  void update(MataKuliah mataKuliah, {String? oldKode}) {
    final targetKode = (oldKode != null && oldKode.isNotEmpty) ? oldKode : mataKuliah.kode;
    final index = _dataMataKuliah.indexWhere(
      (m) => m.kode.toLowerCase() == targetKode.toLowerCase(),
    );
    if (index != -1) {
      _dataMataKuliah[index] = mataKuliah;
    }
  }

  @override
  void delete(MataKuliah mataKuliah) {
    _dataMataKuliah.removeWhere((m) => m.kode == mataKuliah.kode);
  }

  @override
  bool existsKode(String kode, {String? excludeKode}) {
    return _dataMataKuliah.any(
      (m) => m.kode.toLowerCase() == kode.toLowerCase() && m.kode != excludeKode,
    );
  }

  @override
  List<MataKuliah> getFilteredAndSorted({
    String keyword = '',
    String filterSks = 'Semua',
    String sortBy = 'Nama A-Z',
  }) {
    List<MataKuliah> hasil = List<MataKuliah>.from(_dataMataKuliah);

    // 1. Search (Pencarian kode, nama, dosen)
    if (keyword.trim().isNotEmpty) {
      final q = keyword.toLowerCase().trim();
      hasil = hasil.where((mk) {
        return mk.nama.toLowerCase().contains(q) ||
            mk.kode.toLowerCase().contains(q) ||
            mk.dosen.toLowerCase().contains(q);
      }).toList();
    }

    // 2. Challenge Filter SKS menggunakan where()
    if (filterSks == '2 SKS') {
      hasil = hasil.where((mk) => mk.sks == 2).toList();
    } else if (filterSks == '3 SKS') {
      hasil = hasil.where((mk) => mk.sks == 3).toList();
    } else if (filterSks == '4 SKS') {
      hasil = hasil.where((mk) => mk.sks == 4).toList();
    }

    // 3. Sorting (Pengurutan)
    // Catatan Instruksi Pengguna:
    // "Untuk sorting SKS yang arahnya tidak ditentukan LKM, pilih urutan naik dan nyatakan pilihan tersebut."
    if (sortBy == 'Nama A-Z') {
      hasil.sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
    } else if (sortBy == 'SKS (Urutan Naik)') {
      // Pilihan eksplisit: urutan naik (ascending: SKS terkecil ke terbesar)
      hasil.sort((a, b) {
        int comp = a.sks.compareTo(b.sks);
        if (comp == 0) {
          return a.nama.compareTo(b.nama); // tie-breaker dengan nama
        }
        return comp;
      });
    }

    return hasil;
  }
}
