import 'dart:math';
import 'package:flutter/material.dart';

class CollectionExplorationPage extends StatelessWidget {
  const CollectionExplorationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Bagian I
    final List<int> nilai = [75, 80, 90, 65, 85, 95, 70];
    final int jumlahData = nilai.length;
    final int nilaiTertinggi = nilai.reduce(max);
    final int nilaiTerendah = nilai.reduce(min);
    final int totalNilai = nilai.reduce((a, b) => a + b);
    final double rataRata = totalNilai / nilai.length;
    final List<int> nilaiLulus = nilai.where((n) => n >= 80).toList();
    final List<int> nilaiRemedial = nilai.where((n) => n < 80).toList();
    final List<int> urutAscending = List<int>.from(nilai)..sort();
    final List<int> urutDescending = List<int>.from(nilai)..sort((a, b) => b.compareTo(a));

    // Data Bagian N
    final List<int> nilaiN = [80, 65, 90, 70, 95];
    final List<int> hasilN = nilaiN.where((n) => n >= 80).toList();
    final int countN = hasilN.length;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eksplorasi Koleksi Dart (Bagian I & N)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Visualisasi interaktif perhitungan dan manipulasi List<int> sesuai panduan LKM.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // Card Data Sumber
            Card(
              color: Colors.indigo.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.dataset_outlined, color: Colors.indigo, size: 36),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Koleksi Bagian I (List<int> nilai):',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            nilai.toString(),
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 8 Tugas Eksplorasi
            Text(
              'Hasil 8 Tugas Eksplorasi Collection:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),

            _buildResultTile(
              nomor: '1',
              judul: 'Hitung Jumlah Data',
              kode: 'nilai.length',
              hasil: '$jumlahData data',
              icon: Icons.format_list_numbered,
              color: Colors.blue,
            ),
            _buildResultTile(
              nomor: '2',
              judul: 'Cari Nilai Tertinggi',
              kode: 'nilai.reduce(max)',
              hasil: '$nilaiTertinggi',
              icon: Icons.arrow_upward,
              color: Colors.green,
            ),
            _buildResultTile(
              nomor: '3',
              judul: 'Cari Nilai Terendah',
              kode: 'nilai.reduce(min)',
              hasil: '$nilaiTerendah',
              icon: Icons.arrow_downward,
              color: Colors.red,
            ),
            _buildResultTile(
              nomor: '4',
              judul: 'Hitung Nilai Rata-rata',
              kode: 'nilai.reduce((a, b) => a + b) / nilai.length',
              hasil: '${rataRata.toStringAsFixed(2)}  (Total: $totalNilai)',
              icon: Icons.calculate_outlined,
              color: Colors.amber.shade800,
            ),
            _buildResultTile(
              nomor: '5',
              judul: 'Ambil Data Nilai ≥ 80',
              kode: 'nilai.where((n) => n >= 80).toList()',
              hasil: '$nilaiLulus  (Sebanyak ${nilaiLulus.length} nilai)',
              icon: Icons.check_circle_outline,
              color: Colors.teal,
            ),
            _buildResultTile(
              nomor: '6',
              judul: 'Ambil Data Nilai < 80',
              kode: 'nilai.where((n) => n < 80).toList()',
              hasil: '$nilaiRemedial  (Sebanyak ${nilaiRemedial.length} nilai)',
              icon: Icons.error_outline,
              color: Colors.deepOrange,
            ),
            _buildResultTile(
              nomor: '7',
              judul: 'Urutkan dari Kecil ke Besar (Ascending)',
              kode: 'List.from(nilai)..sort()',
              hasil: '$urutAscending',
              icon: Icons.sort,
              color: Colors.purple,
            ),
            _buildResultTile(
              nomor: '8',
              judul: 'Urutkan dari Besar ke Kecil (Descending)',
              kode: 'List.from(nilai)..sort((a, b) => b.compareTo(a))',
              hasil: '$urutDescending',
              icon: Icons.swap_vert,
              color: Colors.indigo,
            ),

            const SizedBox(height: 24),

            // Card Bagian N: Problem Solving
            Card(
              color: Colors.teal.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.teal.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.psychology_outlined, color: Colors.teal, size: 28),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Bagian N: Problem Solving',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade900,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Soal: List<int> nilai = [80, 65, 90, 70, 95];\n'
                      'Ambil nilai ≥ 80 dan hitung jumlah data yang memenuhi.',
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'var hasil = nilai.where((n) => n >= 80).toList();\n'
                        'int count = hasil.length; // atau nilai.where((n) => n >= 80).length',
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.teal.shade200),
                          ),
                          child: Text(
                            'Data Lolos: $hasilN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              color: Colors.teal.shade900,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Jumlah Data: $countN data',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultTile({
    required String nomor,
    required String judul,
    required String kode,
    required String hasil,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withValues(alpha: 0.12),
              foregroundColor: color,
              child: Text(nomor, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    kode,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hasil: ',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      Expanded(
                        child: Text(
                          hasil,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(icon, color: color.withValues(alpha: 0.5), size: 24),
          ],
        ),
      ),
    );
  }
}
