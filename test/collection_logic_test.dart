import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_2_collection/models/mahasiswa.dart';
import 'package:tugas_2_collection/repositories/mahasiswa_repository.dart';
import 'package:tugas_2_collection/repositories/mata_kuliah_repository.dart';
import 'package:tugas_2_collection/repositories/barang_repository.dart';

void main() {
  group('A. Pengujian Eksplorasi Koleksi (Bagian I & N)', () {
    final List<int> nilai = [75, 80, 90, 65, 85, 95, 70];

    test('1. Jumlah data harus 7', () {
      expect(nilai.length, equals(7));
    });

    test('2. Nilai tertinggi harus 95', () {
      expect(nilai.reduce(max), equals(95));
    });

    test('3. Nilai terendah harus 65', () {
      expect(nilai.reduce(min), equals(65));
    });

    test('4. Rata-rata nilai harus 80.0', () {
      final total = nilai.reduce((a, b) => a + b);
      final avg = total / nilai.length;
      expect(total, equals(560));
      expect(avg, equals(80.0));
    });

    test('5. Nilai >= 80 harus berisi [80, 90, 85, 95] dengan panjang 4', () {
      final hasil = nilai.where((n) => n >= 80).toList();
      expect(hasil, equals([80, 90, 85, 95]));
      expect(hasil.length, equals(4));
    });

    test('6. Nilai < 80 harus berisi [75, 65, 70] dengan panjang 3', () {
      final hasil = nilai.where((n) => n < 80).toList();
      expect(hasil, equals([75, 65, 70]));
      expect(hasil.length, equals(3));
    });

    test('7. Pengurutan naik (ascending)', () {
      final asc = List<int>.from(nilai)..sort();
      expect(asc, equals([65, 70, 75, 80, 85, 90, 95]));
    });

    test('8. Pengurutan turun (descending)', () {
      final desc = List<int>.from(nilai)..sort((a, b) => b.compareTo(a));
      expect(desc, equals([95, 90, 85, 80, 75, 70, 65]));
    });

    test('Bagian N: Problem Solving nilai >= 80 dari [80, 65, 90, 70, 95]', () {
      final listN = [80, 65, 90, 70, 95];
      final hasilN = listN.where((n) => n >= 80).toList();
      expect(hasilN, equals([80, 90, 95]));
      expect(hasilN.length, equals(3));
    });
  });

  group('B. Pengujian Repository Mahasiswa (CRUD, Filter, Sort, Validasi)', () {
    late InMemoryMahasiswaRepository repo;

    setUp(() {
      repo = InMemoryMahasiswaRepository();
    });

    test('Data awal berjumlah 6 mahasiswa', () {
      expect(repo.getAll().length, equals(6));
    });

    test('Tambah mahasiswa baru berhasil dan keunikan NIM divalidasi', () {
      expect(repo.existsNim('23010001'), isTrue);
      expect(repo.existsNim('23010099'), isFalse);

      final baru = Mahasiswa(
        nim: '23010099',
        nama: 'Gita Gutawa',
        prodi: 'Sistem Informasi',
        semester: 1,
        ipk: 3.90,
      );
      repo.add(baru);

      expect(repo.getAll().length, equals(7));
      expect(repo.existsNim('23010099'), isTrue);
    });

    test('Update data mahasiswa berhasil', () {
      final mhs = repo.getAll().first;
      final updated = mhs.copyWith(nama: 'Ahmad Fauzi S.Kom', ipk: 3.95);
      repo.update(updated);

      final check = repo.getAll().firstWhere((m) => m.nim == mhs.nim);
      expect(check.nama, equals('Ahmad Fauzi S.Kom'));
      expect(check.ipk, equals(3.95));
    });

    test('Edit NIM mahasiswa berhasil mengubah NIM lama ke NIM baru dan data terupdate', () {
      final mhs = repo.getAll().firstWhere((m) => m.nim == '23010001');
      final updated = mhs.copyWith(nim: '23010999', nama: 'Ahmad Fauzi Baru');
      repo.update(updated, oldNim: '23010001');

      expect(repo.existsNim('23010001'), isFalse);
      expect(repo.existsNim('23010999'), isTrue);
      final check = repo.getAll().firstWhere((m) => m.nim == '23010999');
      expect(check.nama, equals('Ahmad Fauzi Baru'));
    });

    test('Delete mahasiswa berhasil', () {
      final target = repo.getAll().firstWhere((m) => m.nim == '23010002');
      repo.delete(target);

      expect(repo.getAll().length, equals(5));
      expect(repo.existsNim('23010002'), isFalse);
    });

    test('Search berdasarkan multi-field (NIM, Nama, Prodi, Semester)', () {
      // Cari nama
      final resNama = repo.getFilteredAndSorted(keyword: 'Citra');
      expect(resNama.length, equals(1));
      expect(resNama.first.nama, equals('Citra Lestari'));

      // Cari prodi
      final resProdi = repo.getFilteredAndSorted(keyword: 'Komputer');
      expect(resProdi.length, equals(1));
      expect(resProdi.first.nim, equals('23010006'));

      // Cari semester
      final resSem = repo.getFilteredAndSorted(keyword: '7');
      expect(resSem.any((m) => m.semester == 7), isTrue);
    });

    test('Filter IPK >= 3.50 dan IPK < 3.50', () {
      final cumlaude = repo.getFilteredAndSorted(filterIpk: 'IPK ≥ 3.50');
      for (final m in cumlaude) {
        expect(m.ipk >= 3.50, isTrue);
      }

      final nonCumlaude = repo.getFilteredAndSorted(filterIpk: 'IPK < 3.50');
      for (final m in nonCumlaude) {
        expect(m.ipk < 3.50, isTrue);
      }
    });

    test('Sorting Nama A-Z, Z-A, dan IPK', () {
      final sortAz = repo.getFilteredAndSorted(sortBy: 'Nama A-Z');
      expect(sortAz.first.nama, startsWith('Ahmad'));

      final sortZa = repo.getFilteredAndSorted(sortBy: 'Nama Z-A');
      expect(sortZa.first.nama, startsWith('Farhan'));

      final sortIpkDesc = repo.getFilteredAndSorted(sortBy: 'IPK Tertinggi');
      expect(sortIpkDesc.first.ipk, equals(3.85)); // Citra Lestari
    });
  });

  group('C. Pengujian Repository Mata Kuliah & Challenge', () {
    late InMemoryMataKuliahRepository repo;

    setUp(() {
      repo = InMemoryMataKuliahRepository();
    });

    test('Data awal berjumlah 6 mata kuliah', () {
      expect(repo.getAll().length, equals(6));
    });

    test('Challenge Filter SKS (2 SKS, 3 SKS, 4 SKS)', () {
      final sks2 = repo.getFilteredAndSorted(filterSks: '2 SKS');
      expect(sks2.length, equals(2));
      for (final mk in sks2) {
        expect(mk.sks, equals(2));
      }

      final sks3 = repo.getFilteredAndSorted(filterSks: '3 SKS');
      expect(sks3.length, equals(3));
      for (final mk in sks3) {
        expect(mk.sks, equals(3));
      }

      final sks4 = repo.getFilteredAndSorted(filterSks: '4 SKS');
      expect(sks4.length, equals(1));
      expect(sks4.first.nama, equals('Struktur Data & Algoritma'));
    });

    test('Sorting SKS urutan naik (ascending) terverifikasi', () {
      final sortedSks = repo.getFilteredAndSorted(sortBy: 'SKS (Urutan Naik)');
      // Urutan naik harus menempatkan SKS 2 di awal dan SKS 4 di akhir
      expect(sortedSks.first.sks, equals(2));
      expect(sortedSks.last.sks, equals(4));

      // Verifikasi urutan monoton tidak turun
      for (int i = 0; i < sortedSks.length - 1; i++) {
        expect(sortedSks[i].sks <= sortedSks[i + 1].sks, isTrue);
      }
    });

    test('Perhitungan ringkasan dinamis (Total SKS & Rata-rata SKS)', () {
      final all = repo.getFilteredAndSorted(filterSks: 'Semua');
      final totalSks = all.map((m) => m.sks).reduce((a, b) => a + b);
      expect(totalSks, equals(17)); // 3 + 4 + 3 + 2 + 3 + 2 = 17
      expect((totalSks / all.length), closeTo(2.83, 0.01));

      // Saat difilter 3 SKS
      final list3 = repo.getFilteredAndSorted(filterSks: '3 SKS');
      final total3 = list3.map((m) => m.sks).reduce((a, b) => a + b);
      expect(total3, equals(9)); // 3 * 3 = 9
      expect(total3 / list3.length, equals(3.0));
    });

    test('Edit Kode mata kuliah berhasil mengubah kode lama ke kode baru dan data terupdate', () {
      final mk = repo.getAll().firstWhere((m) => m.kode == 'IF2101');
      final updated = mk.copyWith(kode: 'IF2999', nama: 'Pemrograman Mobile Lanjut');
      repo.update(updated, oldKode: 'IF2101');

      expect(repo.existsKode('IF2101'), isFalse);
      expect(repo.existsKode('IF2999'), isTrue);
      final check = repo.getAll().firstWhere((m) => m.kode == 'IF2999');
      expect(check.nama, equals('Pemrograman Mobile Lanjut'));
    });
  });

  group('D. Pengujian Repository Barang & Nilai Persediaan (Bagian K)', () {
    late InMemoryBarangRepository repo;

    setUp(() {
      repo = InMemoryBarangRepository();
    });

    test('Data awal berjumlah 5 jenis barang', () {
      expect(repo.getAll().length, equals(5));
    });

    test('Edit Kode barang berhasil mengubah kode lama ke kode baru dan data terupdate', () {
      final b = repo.getAll().firstWhere((b) => b.kode == 'BRG001');
      final updated = b.copyWith(kode: 'BRG999', nama: 'Laptop Gaming Pro');
      repo.update(updated, oldKode: 'BRG001');

      expect(repo.existsKode('BRG001'), isFalse);
      expect(repo.existsKode('BRG999'), isTrue);
      final check = repo.getAll().firstWhere((b) => b.kode == 'BRG999');
      expect(check.nama, equals('Laptop Gaming Pro'));
    });

    test('Perhitungan nilai tiap barang = stok * harga', () {
      final laptop = repo.getAll().firstWhere((b) => b.kode == 'BRG001' || b.kode == 'BRG999');
      // 10 unit * Rp 15.000.000 = Rp 150.000.000
      expect(laptop.nilaiTotal, equals(150000000.0));

      final mouse = repo.getAll().firstWhere((b) => b.kode == 'BRG002');
      // 25 unit * Rp 250.000 = Rp 6.250.000
      expect(mouse.nilaiTotal, equals(6250000.0));
    });

    test('Total nilai persediaan gudang = sigma(stok * harga)', () {
      // Laptop: 10 * 15.000.000 = 150.000.000
      // Mouse: 25 * 250.000 = 6.250.000
      // Keyboard: 15 * 750.000 = 11.250.000
      // Monitor: 8 * 2.100.000 = 16.800.000
      // SSD: 20 * 1.300.000 = 26.000.000
      // Total = 150m + 6.25m + 11.25m + 16.8m + 26m = 210.300.000
      final totalPersediaan = repo.hitungTotalPersediaan(repo.getAll());
      expect(totalPersediaan, equals(210300000.0));
    });
  });
}
