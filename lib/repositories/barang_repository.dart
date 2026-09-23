import '../models/barang.dart';

/// Kontrak Repository Barang (Tugas Pengayaan K LKM)
abstract class BarangRepository {
  List<Barang> getAll();
  void add(Barang barang);
  void update(Barang barang, {String? oldKode});
  void delete(Barang barang);
  bool existsKode(String kode, {String? excludeKode});
  List<Barang> getFiltered({String keyword = ''});
  double hitungTotalPersediaan(List<Barang> items);
}

/// Implementasi In-Memory List Repository Barang
class InMemoryBarangRepository implements BarangRepository {
  final List<Barang> _dataBarang = [
    Barang(
      kode: 'BRG001',
      nama: 'Laptop Asus ROG Zephyrus',
      stok: 10,
      harga: 15000000.0,
    ),
    Barang(
      kode: 'BRG002',
      nama: 'Mouse Wireless Logitech MX',
      stok: 25,
      harga: 250000.0,
    ),
    Barang(
      kode: 'BRG003',
      nama: 'Keyboard Mechanical RGB TKL',
      stok: 15,
      harga: 750000.0,
    ),
    Barang(
      kode: 'BRG004',
      nama: 'Monitor IPS 24 Inch 144Hz',
      stok: 8,
      harga: 2100000.0,
    ),
    Barang(
      kode: 'BRG005',
      nama: 'External SSD NVMe 1TB',
      stok: 20,
      harga: 1300000.0,
    ),
  ];

  @override
  List<Barang> getAll() {
    return List.unmodifiable(_dataBarang);
  }

  @override
  void add(Barang barang) {
    _dataBarang.add(barang);
  }

  @override
  void update(Barang barang, {String? oldKode}) {
    final targetKode = (oldKode != null && oldKode.isNotEmpty) ? oldKode : barang.kode;
    final index = _dataBarang.indexWhere(
      (b) => b.kode.toLowerCase() == targetKode.toLowerCase(),
    );
    if (index != -1) {
      _dataBarang[index] = barang;
    }
  }

  @override
  void delete(Barang barang) {
    _dataBarang.removeWhere((b) => b.kode == barang.kode);
  }

  @override
  bool existsKode(String kode, {String? excludeKode}) {
    return _dataBarang.any(
      (b) => b.kode.toLowerCase() == kode.toLowerCase() && b.kode != excludeKode,
    );
  }

  @override
  List<Barang> getFiltered({String keyword = ''}) {
    if (keyword.trim().isEmpty) {
      return List<Barang>.from(_dataBarang);
    }
    final q = keyword.toLowerCase().trim();
    return _dataBarang.where((b) {
      return b.nama.toLowerCase().contains(q) || b.kode.toLowerCase().contains(q);
    }).toList();
  }

  @override
  double hitungTotalPersediaan(List<Barang> items) {
    if (items.isEmpty) return 0.0;
    return items.map((b) => b.nilaiTotal).reduce((a, b) => a + b);
  }
}
