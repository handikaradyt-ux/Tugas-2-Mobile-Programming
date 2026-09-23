// ignore_for_file: avoid_print

// ============================================================================
// LEMBAR KERJA MAHASISWA (LKM) - MOBILE PROGRAMMING
// BAGIAN I: EKSPLORASI COLLECTION & BAGIAN N: PROBLEM SOLVING
// ============================================================================
// Berkas ini dapat dijalankan langsung dengan perintah:
//   dart run bin/eksplorasi_collection.dart
// ============================================================================

import 'dart:math';

void main() {
  print('================================================================');
  print('LKM DART: BAGIAN I (EKSPLORASI COLLECTION) & BAGIAN N');
  print('================================================================\n');

  // Data sumber Bagian I
  List<int> nilai = [75, 80, 90, 65, 85, 95, 70];
  print('Data Awal: $nilai\n');

  // 1. Hitung jumlah data
  int jumlahData = nilai.length;
  print('1. Jumlah data: $jumlahData');

  // 2. Cari nilai tertinggi
  int nilaiTertinggi = nilai.reduce(max);
  print('2. Nilai tertinggi: $nilaiTertinggi');

  // 3. Cari nilai terendah
  int nilaiTerendah = nilai.reduce(min);
  print('3. Nilai terendah: $nilaiTerendah');

  // 4. Hitung nilai rata-rata
  int totalNilai = nilai.reduce((a, b) => a + b);
  double rataRata = totalNilai / nilai.length;
  print('4. Nilai rata-rata: ${rataRata.toStringAsFixed(2)} (Total: $totalNilai / $jumlahData)');

  // 5. Ambil data nilai >= 80
  List<int> nilaiLulus = nilai.where((n) => n >= 80).toList();
  print('5. Nilai >= 80: $nilaiLulus (Jumlah: ${nilaiLulus.length})');

  // 6. Ambil data nilai < 80
  List<int> nilaiRemedial = nilai.where((n) => n < 80).toList();
  print('6. Nilai < 80: $nilaiRemedial (Jumlah: ${nilaiRemedial.length})');

  // 7. Urutkan dari kecil ke besar (Ascending)
  List<int> urutAscending = List<int>.from(nilai)..sort();
  print('7. Urutan kecil ke besar (Ascending): $urutAscending');

  // 8. Urutkan dari besar ke kecil (Descending)
  List<int> urutDescending = List<int>.from(nilai)..sort((a, b) => b.compareTo(a));
  print('8. Urutan besar ke kecil (Descending): $urutDescending');

  print('\n----------------------------------------------------------------');
  print('BAGIAN N: PROBLEM SOLVING');
  print('----------------------------------------------------------------');
  List<int> nilaiSoalN = [80, 65, 90, 70, 95];
  print('Data Problem Solving: $nilaiSoalN');

  // Kode untuk mengambil nilai >= 80 dan menghitung jumlah datanya
  var hasilN = nilaiSoalN.where((n) => n >= 80).toList();
  int jumlahLolosN = hasilN.length;

  print('Kode Solusi:');
  print('  var hasil = nilai.where((n) => n >= 80).toList();');
  print('  int jumlah = hasil.length;');
  print('Hasil filter nilai >= 80 : $hasilN');
  print('Jumlah data yang memenuhi : $jumlahLolosN');
  print('================================================================');
}
