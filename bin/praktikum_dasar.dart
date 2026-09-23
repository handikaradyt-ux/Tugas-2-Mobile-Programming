// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

// ============================================================================
// LEMBAR KERJA MAHASISWA (LKM) - MOBILE PROGRAMMING
// PRAKTIKUM DASAR 1 - 9: KOLEKSI DAN LIST PADA DART
// ============================================================================
// Berkas ini dapat dijalankan langsung dengan perintah:
//   dart run bin/praktikum_dasar.dart
// ============================================================================

void main() {
  print('================================================================');
  print('LKM DART COLLECTION: PRAKTIKUM DASAR 1 - 9');
  print('================================================================\n');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 1 – Membuat List
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 1: Membuat List ---');
  List<String> mahasiswa = ['Ahmad', 'Budi', 'Citra', 'Dewi'];
  print('Keluaran Program:');
  print(mahasiswa);
  // Penjelasan: List diinisialisasi dengan 4 elemen String bertipe List<String>.
  print('');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 2 – Mengakses Data List
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 2: Mengakses Data List ---');
  print('mahasiswa[0]     : ${mahasiswa[0]}');
  print('mahasiswa.first  : ${mahasiswa.first}');
  print('mahasiswa.last   : ${mahasiswa.last}');
  print('mahasiswa.length : ${mahasiswa.length}');
  print('mahasiswa.isEmpty: ${mahasiswa.isEmpty}');
  print('mahasiswa.isNotEmpty: ${mahasiswa.isNotEmpty}');
  print('\n[Analisis Pertanyaan Praktikum 2]');
  print('Pertanyaan: Apa perbedaan mahasiswa[0] dengan mahasiswa.first?');
  print('Jawaban   : ');
  print('1. Mekanisme Akses: mahasiswa[0] menggunakan operator indexing (random access)');
  print('   berdasarkan posisi memori offset. Sedangkan mahasiswa.first adalah getter dari');
  print('   antarmuka Iterable.');
  print('2. Perilaku saat List Kosong:');
  print('   - Jika list kosong, mahasiswa[0] melempar RangeError (Index out of range).');
  print('   - Jika list kosong, mahasiswa.first melempar StateError (Bad state: No element).');
  print('3. Fleksibilitas Tipe: mahasiswa.first dapat bekerja pada semua jenis Iterable');
  print('   (seperti Set, WhereIterable), sedangkan indexing [0] hanya ada pada List.');
  print('');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 3 – Menambah Data
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 3: Menambah Data ---');
  // CATATAN PENTING ALUR KODE LKM:
  // List awal sudah memiliki 'Citra' dan 'Dewi'. Jika add('Citra') dan addAll(['Dewi', 'Eka', 'Farhan'])
  // dijalankan langsung pada list yang sama, maka list akan memiliki nama duplikat karena List
  // mengizinkan elemen duplikat (berbeda dengan Set).
  mahasiswa.add('Citra');
  mahasiswa.addAll(['Dewi', 'Eka', 'Farhan']);
  print('Prediksi & Hasil Output:');
  print(mahasiswa);
  print('Catatan: Terjadi duplikasi nama ("Citra" muncul 2x, "Dewi" muncul 2x) karena List');
  print('mengizinkan elemen berulang.');
  print('');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 4 – Mengubah Data
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 4: Mengubah Data ---');
  mahasiswa[1] = 'Budi Santoso';
  print('Hasil setelah mahasiswa[1] = "Budi Santoso":');
  print(mahasiswa);
  print('\n[Analisis Pertanyaan Praktikum 4]');
  print('Pertanyaan: Data apa yang berubah dan mengapa indeks yang digunakan adalah 1?');
  print('Jawaban   : Data yang berubah adalah elemen kedua, yaitu "Budi" menjadi "Budi Santoso".');
  print('Indeks yang digunakan adalah 1 karena indeks List pada bahasa Dart (dan mayoritas');
  print('bahasa pemrograman modern) berbasis nol (zero-based indexing). Elemen pertama');
  print('berada pada indeks 0 ("Ahmad"), sehingga elemen kedua berada pada indeks 1.');
  print('');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 5 – Menghapus Data
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 5: Menghapus Data ---');
  print('List sebelum dihapus: $mahasiswa');
  mahasiswa.remove('Budi Santoso'); // Menghapus berdasarkan nilai (objek pertama yang cocok)
  print('Setelah remove("Budi Santoso"): $mahasiswa');
  mahasiswa.removeAt(0);            // Menghapus elemen pada indeks 0 ('Ahmad')
  print('Setelah removeAt(0)           : $mahasiswa');
  mahasiswa.removeLast();          // Menghapus elemen terakhir ('Farhan')
  print('Setelah removeLast()          : $mahasiswa');
  mahasiswa.clear();               // Menghapus seluruh elemen
  print('Setelah clear()               : $mahasiswa (length: ${mahasiswa.length})');
  print('PENTING: List mahasiswa sekarang benar-benar KOSONG (length = 0).');
  print('');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 6 – Iterasi Data
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 6: Iterasi Data ---');
  print('KONDISI AKTUAL: Karena Praktikum 5 memanggil clear(), list mahasiswa kosong.');
  print('Jika loop dijalankan pada list kosong, tidak ada elemen yang dicetak:');
  for (int i = 0; i < mahasiswa.length; i++) {
    print('Loop biasa (kosong): ${mahasiswa[i]}');
  }

  print('\n[LANGKAH TAMBAHAN UNTUK DEMONSTRASI ITERASI]:');
  print('Mengisi ulang data list agar demonstrasi 3 cara iterasi dapat berjalan:');
  mahasiswa = ['Ahmad', 'Budi Santoso', 'Citra', 'Dewi'];

  print('1. Menggunakan for standar berindeks:');
  for (int i = 0; i < mahasiswa.length; i++) {
    print('   [Index $i]: ${mahasiswa[i]}');
  }

  print('2. Menggunakan for-in loop:');
  for (String nama in mahasiswa) {
    print('   Nama: $nama');
  }

  print('3. Menggunakan forEach() higher-order function:');
  mahasiswa.forEach((nama) {
    print('   forEach: $nama');
  });

  print('\n[Analisis Pertanyaan Praktikum 6]');
  print('Pertanyaan: Cara iterasi mana yang paling mudah menurut Anda? Jelaskan alasannya.');
  print('Jawaban   : Cara yang paling mudah dan direkomendasikan untuk pembacaan data sederhana');
  print('adalah perulangan for-in (for (String nama in mahasiswa)).');
  print('Alasan:');
  print('- Sintaks sangat bersih, deklaratif, dan mudah dipahami layaknya bahasa manusia.');
  print('- Menghindari kesalahan manusia pada batas indeks (misalnya Off-By-One Error pada for biasa).');
  print('- Tetap mendukung kata kunci kontrol aliran standar seperti "break", "continue", atau "return",');
  print('  yang tidak bisa digunakan secara langsung di dalam callback forEach().');
  print('');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 7 – Filtering dengan where()
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 7: Filtering dengan where() ---');
  // Memakai list baru sesuai potongan kode LKM Praktikum 7:
  List<String> listPraktikum7 = ['Ahmad', 'Budi', 'Andi', 'Citra', 'Anisa'];
  var hasilFilterA = listPraktikum7
      .where((nama) => nama.startsWith('A'))
      .toList();
  print('List sumber: $listPraktikum7');
  print('Hasil filter nama berawalan "A": $hasilFilterA');
  print('');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 8 – Transformasi dengan map()
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 8: Transformasi dengan map() ---');
  // Menggunakan nama variabel terpisah (hasilTransformasiUpper) agar tidak bentrok dengan scope Praktikum 7
  var hasilTransformasiUpper = listPraktikum7
      .map((nama) => nama.toUpperCase())
      .toList();
  print('Hasil transformasi huruf kapital: $hasilTransformasiUpper');
  print('\n[Analisis Pertanyaan Praktikum 8]');
  print('Pertanyaan: Jelaskan fungsi map():');
  print('Jawaban   : map() adalah higher-order method pada Iterable yang digunakan untuk mentransformasi');
  print('setiap elemen dalam koleksi menjadi nilai baru berdasarkan fungsi konversi yang diberikan.');
  print('Sifat map():');
  print('1. Menghasilkan Iterable baru berukuran sama persis dengan koleksi awal (1-to-1 mapping).');
  print('2. Bersifat lazy (evaluasi tunda), sehingga pemanggilan .toList() diperlukan jika ingin');
  print('   mengevaluasi dan menyimpannya kembali dalam bentuk List konkret.');
  print('3. Tidak mengubah (immutable) data pada List sumber aslinya.');
  print('');

  // --------------------------------------------------------------------------
  // PRAKTIKUM 9 – Sorting
  // --------------------------------------------------------------------------
  print('--- PRAKTIKUM 9: Sorting ---');
  List<String> listSorting = ['Ahmad', 'Budi', 'Andi', 'Citra', 'Anisa'];
  print('List sebelum sort: $listSorting');

  // Mengurutkan ascending (A-Z)
  listSorting.sort();
  print('Hasil mahasiswa.sort() [Ascending A-Z]:');
  print(listSorting);

  // Mengurutkan descending (Z-A) menggunakan reversed.toList()
  var descending = listSorting.reversed.toList();
  print('Hasil mahasiswa.reversed.toList() [Descending Z-A]:');
  print(descending);
  print('\n================================================================');
  print('SELESAI PRAKTIKUM DASAR 1 - 9');
  print('================================================================');
}
