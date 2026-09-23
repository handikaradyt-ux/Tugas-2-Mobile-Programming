# DOKUMEN JAWABAN LENGKAP & LAPORAN PRAKTIKUM
## LEMBAR KERJA MAHASISWA (LKM): MENGELOLA DATA LIST ATAU KOLEKSI DENGAN FLUTTER DAN DART PROGRAMMING

---

### IDENTITAS MAHASISWA & MATA KULIAH
| Parameter | Informasi |
| :--- | :--- |
| **Mata Kuliah** | Mobile Programming |
| **Program Studi** | Teknik Informatika |
| **Materi** | Collection, List, Set, Map, dan Dynamic List pada Flutter |
| **Bentuk Kegiatan** | Praktikum Terbimbing dan Mandiri |
| **Alokasi Waktu** | 3 × 50 menit |
| **Nama Mahasiswa** | *[Silakan isi Nama Anda]* |
| **NIM** | *[Silakan isi NIM Anda]* |
| **Kelas** | *[Silakan isi Kelas Anda]* |
| **Tanggal Pengerjaan** | 23 September 2026 |

---

## DAFTAR ISI
1. [Bagian D: Praktikum Dasar List dan Collection (Praktikum 1–9)](#bagian-d-praktikum-dasar-list-dan-collection)
2. [Bagian G & P: Analisis Struktur Program & Siklus Hidup Koleksi di Flutter](#bagian-g--p-analisis-struktur-program--siklus-hidup-koleksi)
3. [Bagian H: Latihan Terbimbing 1–4](#bagian-h-latihan-terbimbing)
4. [Bagian I: Latihan Eksplorasi Collection (8 Tugas Statistik Nilai)](#bagian-i-latihan-eksplorasi-collection)
5. [Bagian J: Tugas Praktikum Individu (Aplikasi Mata Kuliah & Challenge)](#bagian-j-tugas-praktikum-individu-mata-kuliah--challenge)
6. [Bagian K: Tugas Pengayaan (Inventory Barang & Nilai Persediaan)](#bagian-k-tugas-pengayaan-inventory-barang)
7. [Bagian L: Pertanyaan Analisis (10 Soal Komprehensif)](#bagian-l-pertanyaan-analisis)
8. [Bagian M: Analisis Kesalahan Program](#bagian-m-analisis-kesalahan-program)
9. [Bagian N: Problem Solving Koleksi](#bagian-n-problem-solving)
10. [Bagian O: Mini Project Student Management App](#bagian-o-mini-project-student-management-app)
11. [Bagian Q: Checklist 10 Indikator Keberhasilan Praktikum](#bagian-q-checklist-10-indikator-keberhasilan-praktikum)
12. [Bagian U: Refleksi Mahasiswa](#bagian-u-refleksi-mahasiswa)
13. [Bagian V: Arsitektur Pemisahan Kode & Rencana Transisi ke Database/API](#bagian-v-arsitektur-pemisahan-kode--rencana-transisi)
14. [Lampiran: Bukti Verifikasi Eksekusi Program Nyata](#lampiran-bukti-verifikasi-eksekusi-program-nyata)

---

## BAGIAN D: PRAKTIKUM DASAR LIST DAN COLLECTION

Seluruh kode praktikum dasar telah diimplementasikan dalam berkas executable [`bin/praktikum_dasar.dart`](bin/praktikum_dasar.dart) dan dapat dijalankan langsung menggunakan perintah `dart run bin/praktikum_dasar.dart`.

### Praktikum 1 – Membuat List
```dart
void main() {
  List<String> mahasiswa = ['Ahmad', 'Budi', 'Citra', 'Dewi'];
  print(mahasiswa);
}
```
- **Hasil Keluaran Program:**
  ```text
  [Ahmad, Budi, Citra, Dewi]
  ```
- **Penjelasan:** Program menginisialisasi sebuah variabel koleksi bernama `mahasiswa` bertipe `List<String>` dengan 4 elemen string. Pemanggilan `print(mahasiswa)` mencetak seluruh elemen list dalam tanda kurung siku `[...]`.

---

### Praktikum 2 – Mengakses Data List
```dart
print(mahasiswa[0]);
print(mahasiswa.first);
print(mahasiswa.last);
print(mahasiswa.length);
print(mahasiswa.isEmpty);
print(mahasiswa.isNotEmpty);
```
- **Hasil Keluaran Program:**
  ```text
  mahasiswa[0]     : Ahmad
  mahasiswa.first  : Ahmad
  mahasiswa.last   : Dewi
  mahasiswa.length : 4
  mahasiswa.isEmpty: false
  mahasiswa.isNotEmpty: true
  ```
- **Pertanyaan: Apa perbedaan `mahasiswa[0]` dengan `mahasiswa.first`?**
  - **Mekanisme Akses:** `mahasiswa[0]` menggunakan operator pengindeksan (*subscript operator*) yang bekerja berdasarkan posisi *memory offset* (indeks ke-0). Sedangkan `mahasiswa.first` adalah *getter property* yang didefinisikan pada antarmuka `Iterable`.
  - **Perilaku Saat List Kosong:** Jika list dalam keadaan kosong:
    - `mahasiswa[0]` akan melempar exception `RangeError (Index out of range)`.
    - `mahasiswa.first` akan melempar exception `StateError (Bad state: No element)`.
  - **Dukungan Tipe Koleksi:** `mahasiswa.first` dapat digunakan pada segala jenis tipe turunan `Iterable` (seperti `Set`, `Queue`, hasil chaining `where`), sedangkan operator `[0]` hanya didukung oleh koleksi yang mengimplementasikan `List` (koleksi yang memiliki konsep indeks acak / *random-access*).

---

### Praktikum 3 – Menambah Data
```dart
mahasiswa.add('Citra');
mahasiswa.addAll(['Dewi', 'Eka', 'Farhan']);
print(mahasiswa);
```
- **Prediksi & Hasil Output Nyata:**
  ```text
  [Ahmad, Budi, Citra, Dewi, Citra, Dewi, Eka, Farhan]
  ```
- **Catatan & Analisis Khusus Alur LKM:**
  Jika praktikum dijalankan secara berurutan pada satu instance list yang sama dari Praktikum 1, elemen `'Citra'` dan `'Dewi'` sudah ada di dalam list. Penambahan `add('Citra')` dan `addAll(['Dewi', 'Eka', 'Farhan'])` menyebabkan nama `'Citra'` dan `'Dewi'` muncul dua kali (terjadi duplikasi data). Hal ini membuktikan bahwa struktur data `List` pada Dart mengizinkan elemen duplikat, berbeda dengan `Set` yang secara inheren menolak elemen ganda.

---

### Praktikum 4 – Mengubah Data
```dart
mahasiswa[1] = 'Budi Santoso';
print(mahasiswa);
```
- **Hasil Keluaran Program:**
  ```text
  [Ahmad, Budi Santoso, Citra, Dewi, Citra, Dewi, Eka, Farhan]
  ```
- **Pertanyaan: Data apa yang berubah dan mengapa indeks yang digunakan adalah 1?**
  - **Data yang berubah:** Elemen kedua dalam list, yaitu nilai string `'Budi'` digantikan dengan `'Budi Santoso'`.
  - **Alasan indeks 1 digunakan:** Karena dalam bahasa pemrograman Dart (sebagaimana rumpun bahasa turunan C/Java), penomoran indeks List berbasis nol (*zero-based indexing*). Elemen urutan pertama berada pada indeks 0 (`mahasiswa[0]` yaitu `'Ahmad'`), sehingga elemen urutan kedua berada pada indeks 1 (`mahasiswa[1]`).

---

### Praktikum 5 – Menghapus Data
```dart
mahasiswa.remove('Budi Santoso');
mahasiswa.removeAt(0);
mahasiswa.removeLast();
mahasiswa.clear();
```
- **Hasil Keluaran Program per Tahap:**
  ```text
  List awal                      : [Ahmad, Budi Santoso, Citra, Dewi, Citra, Dewi, Eka, Farhan]
  Setelah remove('Budi Santoso') : [Ahmad, Citra, Dewi, Citra, Dewi, Eka, Farhan]
  Setelah removeAt(0)            : [Citra, Dewi, Citra, Dewi, Eka, Farhan]
  Setelah removeLast()           : [Citra, Dewi, Citra, Dewi, Eka]
  Setelah clear()                : [] (length: 0)
  ```
- **Catatan Kritis Efek `clear()`:**
  Pemanggilan `clear()` menghapus **seluruh** elemen di dalam list `mahasiswa`, sehingga list menjadi kosong total (`length = 0`). Jika kode Praktikum 6 langsung dieksekusi setelah Praktikum 5 tanpa pengisian ulang, maka tidak ada satu pun elemen yang dapat dicetak oleh perulangan iterasi.

---

### Praktikum 6 – Iterasi Data
```dart
// 1. For berindeks
for (int i = 0; i < mahasiswa.length; i++) {
  print(mahasiswa[i]);
}

// 2. For-in loop
for (String nama in mahasiswa) {
  print(nama);
}

// 3. forEach method
mahasiswa.forEach((nama) {
  print(nama);
});
```
- **Kondisi Aktual Setelah Praktikum 5:** Karena Praktikum 5 memanggil `clear()`, list `mahasiswa` berada dalam status kosong (`[]`), sehingga ketiga loop di atas menghasilkan **0 baris keluaran**.
- **[LANGKAH TAMBAHAN UNTUK DEMONSTRASI ITERASI]:**
  Untuk mendemonstrasikan ketiga cara iterasi agar dapat diuji secara visual, dilakukan langkah tambahan yaitu menginisialisasi ulang list: `mahasiswa = ['Ahmad', 'Budi Santoso', 'Citra', 'Dewi'];`.
- **Hasil Keluaran Setelah Langkah Tambahan:**
  ```text
  1. For berindeks:
     [Index 0]: Ahmad
     [Index 1]: Budi Santoso
     [Index 2]: Citra
     [Index 3]: Dewi

  2. For-in loop:
     Nama: Ahmad
     Nama: Budi Santoso
     Nama: Citra
     Nama: Dewi

  3. forEach() method:
     forEach: Ahmad
     forEach: Budi Santoso
     forEach: Citra
     forEach: Dewi
  ```
- **Pertanyaan: Cara iterasi mana yang paling mudah menurut Anda? Jelaskan alasannya.**
  - **Jawaban & Rekomendasi:** Cara iterasi yang paling mudah, bersih, dan direkomendasikan untuk pembacaan data standar adalah **`for-in` loop** (`for (String nama in mahasiswa)`).
  - **Alasan:**
    1. **Sintaks Deklaratif:** Kode sangat mudah dibaca layaknya kalimat bahasa manusia (*"for each item in list"*), tanpa memerlukan variabel counter indeks `i`.
    2. **Mencegah Bug Batas Indeks:** Menghilangkan risiko kesalahan manusia seperti *Off-by-One Error* (misal penggunaan `<=` alih-alih `<`) atau `RangeError`.
    3. **Fleksibilitas Aliran Kontrol:** Berbeda dengan callback `forEach()` yang tidak dapat dihentikan di tengah jalan, perulangan `for-in` tetap mendukung kata kunci kontrol eksekusi seperti `break` (menghentikan loop lebih awal), `continue` (melompati iterasi), maupun `return`.

---

### Praktikum 7 – Filtering dengan `where()`
```dart
List<String> mahasiswa = ['Ahmad', 'Budi', 'Andi', 'Citra', 'Anisa'];

var hasil = mahasiswa
    .where((nama) => nama.startsWith('A'))
    .toList();

print(hasil);
```
- **Hasil Keluaran Program:**
  ```text
  [Ahmad, Andi, Anisa]
  ```
- **Penjelasan:** Method `where()` mengevaluasi setiap elemen menggunakan *predicate closure* `(nama) => nama.startsWith('A')`. Hanya elemen yang menghasilkan nilai boolean `true` yang dipertahankan dalam `Iterable`. Pemanggilan `.toList()` mengubah iterable hasil filter tersebut kembali menjadi List konkret.

---

### Praktikum 8 – Transformasi dengan `map()`
```dart
// Untuk menghindari bentrok scope dengan Praktikum 7,
// variabel hasil dinamai hasilTransformasi / dipisahkan scope-nya:
var hasilTransformasi = mahasiswa
    .map((nama) => nama.toUpperCase())
    .toList();

print(hasilTransformasi);
```
- **Hasil Keluaran Program:**
  ```text
  [AHMAD, BUDI, ANDI, CITRA, ANISA]
  ```
- **Pertanyaan: Jelaskan fungsi `map()`:**
  - `map()` adalah *higher-order method* pada koleksi Dart yang berfungsi untuk mentransformasi/memetakan setiap elemen menjadi nilai atau tipe data baru berdasarkan fungsi proyeksi yang didefinisikan.
  - **Karakteristik Kunci `map()`:**
    1. **Ukuran Koleksi Tetap (1-to-1 Mapping):** Panjang koleksi hasil selalu sama persis dengan koleksi awal (tidak membuang elemen seperti `where`).
    2. **Bersifat Imutabel:** Data pada List sumber asli tidak mengalami perubahan sama sekali (*non-destructive*).
    3. **Evaluasi Tunda (*Lazy Evaluation*):** `map()` menghasilkan objek `MappedIterable`. Komputasi transformasi baru dieksekusi saat elemen tersebut diakses atau dievaluasi secara eksplisit dengan `.toList()`.

---

### Praktikum 9 – Sorting
```dart
mahasiswa.sort();
print(mahasiswa);

var descending = mahasiswa.reversed.toList();
print(descending);
```
- **Hasil Keluaran Program:**
  ```text
  Hasil mahasiswa.sort() [Ascending A-Z]      : [Ahmad, Andi, Anisa, Budi, Citra]
  Hasil mahasiswa.reversed.toList() [Descending Z-A]: [Citra, Budi, Anisa, Andi, Ahmad]
  ```
- **Penjelasan:**
  - Method `sort()` mengurutkan elemen secara *in-place* (mengubah langsung urutan data dalam List). Default sorting pada `String` menggunakan urutan leksikografis (alfabetis A–Z) berdasarkan nilai kode karakter Unicode.
  - Property `.reversed` mengembalikan iterable dengan urutan elemen terbalik, yang saat dikonversi menggunakan `.toList()` menghasilkan List berurutan terbalik (Z–A / *descending*).

---

## BAGIAN G & P: ANALISIS STRUKTUR PROGRAM & SIKLUS HIDUP KOLEKSI

### Diagram Siklus Hidup Arsitektur Data Koleksi di Flutter:
```text
┌──────────────┐     Input User     ┌──────────────┐
│  Form Dialog │ ─────────────────> │  Data Model  │
│  (TextField) │                    │ (Mahasiswa)  │
└──────────────┘                    └──────────────┘
                                           │
                                           ▼ (add / update / delete)
┌──────────────┐                    ┌──────────────┐
│  Flutter UI  │ <───────────────── │ List<Model>  │
│ (Re-rendered)│    setState()      │ (Collection) │
└──────────────┘                    └──────────────┘
       ▲                                   │
       │                                   ▼ (where / sort)
┌──────────────────┐                ┌──────────────┐
│ ListView.builder │ <───────────── │ _dataTampil  │
│  (Lazy Building) │                │(FilteredList)│
└──────────────────┘                └──────────────┘
```

### Penjelasan Keterhubungan Komponen (Bagian G & P):
1. **Model Data (`Mahasiswa`):** Mengenkapsulasi kumpulan atribut yang relevan (NIM, Nama, Prodi, Semester, IPK) ke dalam satu tipe data objek yang terstruktur dan *type-safe*.
2. **Koleksi Utama (`List<Mahasiswa>`):** Berperan sebagai media penyimpanan status (*state*) data lokal di dalam memori aplikasi.
3. **Operasi CRUD:**
   - **Create:** Menggunakan `_dataMahasiswa.add(Mahasiswa(...))`.
   - **Read:** Mengakses elemen berdasarkan indeks `_dataMahasiswa[index]`.
   - **Update:** Memperbarui referensi objek `_dataMahasiswa[index] = updatedMahasiswa`.
   - **Delete:** Menghapus data spesifik menggunakan `_dataMahasiswa.remove(target)` atau `removeWhere()`.
4. **Pencarian & Filtering (`where()`):** Mengisolasi logika penyaringan data tanpa mengubah isi list sumber master `_dataMahasiswa`. Hasil evaluasi `where()` ditampung ke dalam getter `_dataTampil`.
5. **Pengurutan (`sort()`):** Mengatur posisi elemen pada data tampil berdasarkan kriteria tertentu (misal alfabet nama atau nilai IPK).
6. **Peran Kunci `setState()`:** Di Flutter, perubahan pada list memori tidak otomatis memicu perubahan visual pada layar. Pemanggilan `setState()` memberi tahu *Flutter Framework* bahwa *internal state* widget telah kotor (*dirty*), sehingga metode `build()` dipanggil kembali untuk merender ulang tampilan.
7. **Efisiensi `ListView.builder`:** `ListView.builder` merender elemen secara *lazy* (hanya item yang terlihat di viewport layar yang dibangun). Hal ini mencegah konsumsi memori berlebih saat menangani ratusan atau ribuan data dalam koleksi.

---

## BAGIAN H: LATIHAN TERBIMBING

1. **Latihan 1 – Menambahkan Semester:**
   - Atribut `int semester` ditambahkan ke dalam model `Mahasiswa`.
   - Form input diperluas untuk menerima angka semester (1–14).
   - Semester disertakan dalam kolom pencarian (`keyword`) dan ditampilkan pada badge kartu mahasiswa.
2. **Latihan 2 – Menambahkan IPK:**
   - Atribut `double ipk` ditambahkan ke model `Mahasiswa`.
   - Ditampilkan pada UI kartu data dengan format 2 desimal (`ipk.toStringAsFixed(2)`).
   - Diberikan penanda visual khusus (warna hijau/kuning emas dan ikon bintang) untuk mahasiswa berprestasi dengan IPK $\ge 3.50$.
3. **Latihan 3 – Filtering Kategori IPK:**
   - Disediakan filter segmentasi: **Semua**, **IPK $\ge 3.50$**, dan **IPK $< 3.50$**.
   - Diimplementasikan menggunakan `where()`:
     ```dart
     if (filterIpk == 'IPK ≥ 3.50') {
       hasil = hasil.where((mhs) => mhs.ipk >= 3.50).toList();
     } else if (filterIpk == 'IPK < 3.50') {
       hasil = hasil.where((mhs) => mhs.ipk < 3.50).toList();
     }
     ```
4. **Latihan 4 – Sorting Multi-Kriteria:**
   - Disediakan 5 opsi pengurutan melalui menu dropdown:
     - **Nama A–Z:** `a.nama.compareTo(b.nama)`
     - **Nama Z–A:** `b.nama.compareTo(a.nama)`
     - **IPK Tertinggi:** `b.ipk.compareTo(a.ipk)`
     - **IPK Terendah:** `a.ipk.compareTo(b.ipk)`
     - **Semester:** `a.semester.compareTo(b.semester)`

---

## BAGIAN I: LATIHAN EKSPLORASI COLLECTION

Data yang digunakan:
```dart
List<int> nilai = [75, 80, 90, 65, 85, 95, 70];
```

Berikut adalah kode Dart, hasil komputasi nyata, dan penjelasannya untuk **seluruh 8 soal**:

| No | Tugas | Kode Program Dart | Hasil Eksekusi | Penjelasan Teknis |
| :---: | :--- | :--- | :--- | :--- |
| **1** | Hitung jumlah data | `nilai.length` | **`7`** | Property `length` menghitung total elemen yang dialokasikan dalam List. |
| **2** | Cari nilai tertinggi | `nilai.reduce(max)` *(atau via looping/sort)* | **`95`** | Method `reduce` membandingkan elemen berpasangan secara kumulatif untuk menemukan nilai maksimum. |
| **3** | Cari nilai terendah | `nilai.reduce(min)` | **`65`** | Method `reduce` dengan fungsi pembanding minimum menemukan nilai paling kecil dalam list. |
| **4** | Hitung nilai rata-rata | `nilai.reduce((a, b) => a + b) / nilai.length` | **`80.00`** | Menjumlahkan seluruh elemen ($\sum = 560$) lalu membaginya dengan jumlah data ($560 / 7 = 80.0$). |
| **5** | Ambil data nilai $\ge 80$ | `nilai.where((n) => n >= 80).toList()` | **`[80, 90, 85, 95]`** *(4 data)* | `where()` menyaring elemen dengan predikat kondisi $\ge 80$. Urutan elemen asli tetap terjaga. |
| **6** | Ambil data nilai $< 80$ | `nilai.where((n) => n < 80).toList()` | **`[75, 65, 70]`** *(3 data)* | `where()` menyaring elemen dengan kondisi nilai di bawah 80. |
| **7** | Urutkan kecil ke besar | `List.from(nilai)..sort()` | **`[65, 70, 75, 80, 85, 90, 95]`** | `sort()` tanpa parameter mengurutkan angka bertipe `int` secara menaik (*ascending*). |
| **8** | Urutkan besar ke kecil | `List.from(nilai)..sort((a, b) => b.compareTo(a))` | **`[95, 90, 85, 80, 75, 70, 65]`** | Menggunakan custom comparator `b.compareTo(a)` untuk membalik prioritas urutan (*descending*). |

*Seluruh 8 tugas ini diverifikasi berjalan sempurna melalui berkas [`bin/eksplorasi_collection.dart`](bin/eksplorasi_collection.dart) dan unit test otomatis.*

---

## BAGIAN J: TUGAS PRAKTIKUM INDIVIDU (MATA KULIAH & CHALLENGE)

### 1. Model Data Mata Kuliah
```dart
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
}
```

### 2. Fitur yang Diimplementasikan
1. **Menampilkan daftar mata kuliah** menggunakan `ListView.builder` dalam format kartu Material 3.
2. **Menambahkan mata kuliah baru** dengan validasi form (kode unik, nama, SKS 1–6, dosen pengampu).
3. **Mengubah mata kuliah** dengan dialog yang otomatis terisi data lama.
4. **Menghapus mata kuliah** dari koleksi list.
5. **Konfirmasi penghapusan** melalui `AlertDialog` sebelum eksekusi `remove()`.
6. **Pencarian real-time** berbasis kode, nama mata kuliah, atau nama dosen.
7. **Menampilkan jumlah mata kuliah** yang sedang aktif.
8. **Menghitung total SKS** secara otomatis.
9. **Sorting nama mata kuliah A–Z** menggunakan `a.nama.compareTo(b.nama)`.
10. **Sorting berdasarkan SKS:**
    - **Pernyataan Pilihan Arah Sorting SKS:** Sesuai instruksi pengguna karena LKM tidak menentukan arah pengurutan, dipilih **Urutan Naik (*Ascending*: 2 SKS $\rightarrow$ 3 SKS $\rightarrow$ 4 SKS)**. Jika bobot SKS sama, nama mata kuliah digunakan sebagai kriteria penentu berikutnya (*tie-breaker*).

### 3. Challenge Kategori SKS & Ringkasan Dinamis
- **Filter Kategori SKS:** Filter chip untuk kategori **Semua**, **2 SKS**, **3 SKS**, dan **4 SKS** diimplementasikan menggunakan method `where()`.
- **Apakah Ringkasan Mengikuti Filter dan Pencarian?**
  - **YA, SEPENUHNYA MENGIKUTI.**
  - **Penjelasan Implementasi:** Perhitungan jumlah mata kuliah, total SKS, dan rata-rata SKS dihitung langsung dari getter `_dataTampil`, bukan dari list master mentah:
    ```dart
    int get _jumlahMkTampil => _dataTampil.length;
    int get _totalSksTampil => _dataTampil.isEmpty
        ? 0
        : _dataTampil.map((mk) => mk.sks).reduce((a, b) => a + b);
    double get _rataRataSksTampil => _dataTampil.isEmpty
        ? 0.0
        : _totalSksTampil / _dataTampil.length;
    ```
  - **Bukti Reaktivitas:**
    - Saat filter **Semua** dipilih: Menampilkan 6 MK, Total = 17 SKS, Rata-rata = 2.83 SKS.
    - Saat filter **3 SKS** dipilih: Menampilkan 3 MK, Total = 9 SKS, Rata-rata = 3.00 SKS.
    - Saat filter **2 SKS** dipilih: Menampilkan 2 MK, Total = 4 SKS, Rata-rata = 2.00 SKS.
    - Saat kata kunci pencarian dimasukkan (misal: "Mobile"): Menampilkan 1 MK, Total = 3 SKS, Rata-rata = 3.00 SKS.

---

## BAGIAN K: TUGAS PENGAYAAN (INVENTORY BARANG)

### 1. Model Data Barang
```dart
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

  double get nilaiTotal => stok * harga;
}
```

### 2. Rumus Perhitungan
- **Nilai Setiap Barang:**
  $$\text{Nilai Barang} = \text{stok} \times \text{harga}$$
- **Total Persediaan Gudang:**
  $$\text{Total Persediaan} = \sum (\text{stok} \times \text{harga})$$

### 3. Tabel Contoh Data Konkret & Hasil Perhitungan Nyata

| No | Kode | Nama Barang | Stok (Unit) | Harga Satuan (Rp) | Rumus ($\text{stok} \times \text{harga}$) | Nilai Barang (Rp) |
| :-: | :---: | :--- | :-: | :-: | :---: | :-: |
| 1 | `BRG001` | Laptop Asus ROG Zephyrus | 10 | 15.000.000 | $10 \times 15.000.000$ | 150.000.000 |
| 2 | `BRG002` | Mouse Wireless Logitech MX | 25 | 250.000 | $25 \times 250.000$ | 6.250.000 |
| 3 | `BRG003` | Keyboard Mechanical RGB TKL | 15 | 750.000 | $15 \times 750.000$ | 11.250.000 |
| 4 | `BRG004` | Monitor IPS 24 Inch 144Hz | 8 | 2.100.000 | $8 \times 2.100.000$ | 16.800.000 |
| 5 | `BRG005` | External SSD NVMe 1TB | 20 | 1.300.000 | $20 \times 1.300.000$ | 26.000.000 |
| **TOTAL** | — | **5 Jenis Barang** | **78 Unit** | — | **$\sum(\text{Nilai Tiap Barang})$** | **Rp 210.300.000,00** |

- **Implementasi Kode Perhitungan Total Persediaan:**
  ```dart
  double hitungTotalPersediaan(List<Barang> items) {
    if (items.isEmpty) return 0.0;
    return items.map((b) => b.stok * b.harga).reduce((a, b) => a + b);
  }
  ```
- **Keluaran UI:** Tampilan menyajikan kartu metrik ringkasan persediaan total, kartu tiap barang dengan rincian stok, harga satuan, dan subtotal nilai barang yang otomatis diperbarui saat stok atau harga diubah melalui form dialog.

---

## BAGIAN L: PERTANYAAN ANALISIS

Berikut adalah jawaban lengkap dan mendalam untuk **10 Pertanyaan Analisis**:

### 1. Apa perbedaan List, Set, dan Map?
- **List:** Struktur data koleksi linier berurutan (*ordered collection*). Elemen diakses menggunakan indeks numerik berbasis nol (`0, 1, 2, ...`). Mengizinkan adanya elemen duplikat. Contoh: antrean pendaftaran mahasiswa `['Ahmad', 'Budi', 'Ahmad']`.
- **Set:** Struktur data sekumpulan elemen unik tanpa urutan terjamin (*unordered collection of unique items*). Jika nilai yang sama dimasukkan kembali, nilai tersebut akan diabaikan secara otomatis. Tidak memiliki akses indeks acak langsung. Sangat efisien untuk pengujian keanggotaan elemen (`contains`). Contoh: daftar mata kuliah pilihan unik `{'Flutter', 'Data Science', 'AI'}`.
- **Map:** Struktur data berbasis pasangan kunci dan nilai (*key-value pair*). Setiap *key* harus unik, sedangkan *value* boleh duplikat. Nilai diakses menggunakan kunci pemanggilnya (`map[key]`), bukan indeks posisi memori. Contoh: data identitas mahasiswa `{'nim': '23010001', 'nama': 'Ahmad'}`.

### 2. Mengapa indeks List dimulai dari 0?
- Asal-usul indeks berbasis nol (*zero-based indexing*) berakar dari arsitektur perangkat keras dan manajemen memori bahasa C.
- Di level memori komputer, nama variabel array/list merepresentasikan alamat memori awal (*base memory address*). Indeks berfungsi sebagai nilai pergeseran (*offset*) dari alamat awal tersebut.
- Rumus alamat memori elemen ke-$i$ adalah:
  $$\text{Alamat Elemen} = \text{Base Address} + (\text{Index} \times \text{Ukuran Elemen})$$
  Untuk mengakses elemen pertama, elemen tersebut tepat berada di alamat awal tanpa pergeseran sama sekali ($\text{offset} = 0$). Jika penomoran dimulai dari 1, komputer harus melakukan operasi aritmetika tambahan yaitu mengurangkan indeks dengan 1 `(Index - 1)` di setiap operasi pembacaan memori. Oleh karena itu, indeks 0 dipilih demi efisiensi komputasi dan konsistensi matematika penunjuk memori.

### 3. Apa fungsi `add()`?
- Method `add(E value)` berfungsi untuk menambahkan sebuah elemen baru bertipe `E` ke posisi paling akhir (*append*) dari suatu `List`. Kapasitas penyimpanan List akan bertambah secara dinamis sebesar 1 elemen.

### 4. Apa perbedaan `remove()` dan `removeAt()`?
- **`remove(Object? value)`:** Menghapus elemen berdasarkan **pencocokan nilai objek**. Dart akan mencari elemen pertama yang bernilai sama menggunakan operator kesetaraan `==`. Method ini mengembalikan nilai boolean (`true` jika data ditemukan dan berhasil dihapus, `false` jika tidak ditemukan).
- **`removeAt(int index)`:** Menghapus elemen berdasarkan **posisi indeks numerik spesifik**. Method ini mengembalikan objek yang baru saja dihapus dari posisi tersebut. Jika indeks yang diberikan tidak valid (misal negatif atau $\ge \text{length}$), method ini akan melempar exception `RangeError`.

### 5. Apa fungsi `where()`?
- `where(bool test(E element))` adalah method *filtering* turunan antarmuka `Iterable`. Fungsinya adalah menyaring koleksi data berdasarkan kondisi predikat logika boolean tertentu.
- Method ini menguji setiap elemen: jika fungsi `test` mengembalikan `true`, elemen dimasukkan ke dalam iterable hasil; jika `false`, elemen diabaikan.

### 6. Apa fungsi `map()`?
- `map<T>(T toElement(E element))` berfungsi untuk mentransformasi (*mapping*) setiap elemen dalam koleksi menjadi bentuk atau representasi baru berdasarkan fungsi proyeksi yang diberikan.
- Menghasilkan koleksi iterable baru yang jumlah elemennya selalu sama persis dengan koleksi awal (transformasi 1-ke-1), tanpa memodifikasi data pada list sumber aslinya.

### 7. Apa kegunaan `toList()`?
- Method `where()`, `map()`, `take()`, dan operasi iterable lainnya bersifat *lazy* (menghasilkan objek turunan `Iterable` seperti `WhereIterable` atau `MappedIterable` yang belum dialokasikan sebagai array terindeks).
- Pemanggilan `toList()` berguna untuk mengevaluasi iterable tersebut secara instan dan mengubah representasi abstraknya menjadi objek `List` konkret yang dapat dimanipulasi dengan indeks, diurutkan (`sort()`), atau dihitung panjangnya secara instan.

### 8. Mengapa aplikasi Flutter menggunakan `setState()` setelah data List berubah?
- Di Flutter, variabel `State` di dalam memori dan tampilan visual (*RenderObject / Widget Tree*) berada pada siklus yang berbeda.
- Memanipulasi isi list (seperti `list.add()` atau `list.remove()`) hanya mengubah data di RAM, namun tidak secara otomatis memberitahukan *Flutter Engine* untuk menggambar ulang layar.
- Pemanggilan `setState((){ ... })` menandai *element tree* widget terkait sebagai berstatus *dirty* (perlu diperbarui) dan menjadwalkan pemanggilan ulang metode `build()`. Dengan demikian, UI akan dirender ulang dan mencerminkan kondisi data list terbaru.

### 9. Apa keuntungan menggunakan `ListView.builder` dibanding menuliskan widget secara manual?
1. **Efisiensi Memori (*Lazy Loading & Recycling*):** `ListView.builder` hanya membuat (*instantiate*) dan menggambar widget item yang sedang terlihat di layar (*viewport*) pengguna ditambah sedikit buffer. Begitu item bergulir ke luar layar, memorinya didaur ulang.
2. **Skalabilitas Data:** Mampu menangani daftar data dinamis mulai dari puluhan hingga puluhan ribu item tanpa menyebabkan lonjakan memori (*out of memory*) atau lag grafis (*frame drop*). Sebaliknya, menuliskan widget secara manual atau menggunakan `Column`/`ListView(children: [...])` akan memaksa Flutter membangun seluruh widget sekaligus di memori saat inisialisasi awal.

### 10. Mengapa model `Mahasiswa` lebih baik dibanding menggunakan banyak `List<String>` terpisah?
- Jika menggunakan list terpisah (`List<String> listNim`, `List<String> listNama`, `List<String> listProdi`):
  - **Rawan Desinkronisasi Data (*Index Misalignment*):** Jika operasi hapus atau urutkan (*sort*) dilakukan pada salah satu list dan lupa diterapkan pada list lainnya, maka data NIM mahasiswa A bisa tertukar dengan nama mahasiswa B.
  - **Tipe Data Tidak Aman (*Type Safety*):** Sulit menyimpan tipe data beragam (seperti IPK double dan semester int) tanpa konversi string manual.
- Menggunakan Model Objek (`Mahasiswa`):
  - **Atomisitas Data & Integritas:** Seluruh atribut mahasiswa terikat dalam satu objek tunggal yang utuh. Pemindahan, pengurutan, atau penghapusan satu objek mahasiswa otomatis membawa seluruh identitasnya secara konsisten.
  - **Prinsip *Object-Oriented Programming* (OOP):** Memungkinkan enkapsulasi logika bisnis, metode pembantu (seperti `copyWith`, konversi JSON/Map), serta validasi internal.

---

## BAGIAN M: ANALISIS KESALAHAN PROGRAM

### Potongan Kode:
```dart
List<String> mahasiswa = ['Ahmad', 'Budi'];
print(mahasiswa[5]);
```

### 1. Apa yang terjadi?
Program akan mengalami *crash* (*runtime exception*) dan menghentikan eksekusi dengan pesan kesalahan:
```text
Unhandled exception:
RangeError (index): Invalid value: Not in inclusive range 0..1: 5
```

### 2. Mengapa hal tersebut terjadi?
List `mahasiswa` hanya diinisialisasi dengan 2 elemen string. Karena Dart menggunakan sistem indeks berbasis nol (*zero-based indexing*), indeks yang sah (*valid range*) untuk list tersebut adalah indeks **`0`** (untuk `'Ahmad'`) dan indeks **`1`** (untuk `'Budi'`). Ketika program mencoba mengakses indeks `5`, Dart mendeteksi bahwa indeks tersebut berada di luar rentang alokasi memori elemen yang tersedia (`index < length`).

### 3. Bagaimana cara menghindarinya?
Ada beberapa teknik defensif untuk mencegah terjadinya `RangeError`:
1. **Pemeriksaan Batas Indeks (*Boundary Check*):**
   ```dart
   int indexYangDicari = 5;
   if (indexYangDicari >= 0 && indexYangDicari < mahasiswa.length) {
     print(mahasiswa[indexYangDicari]);
   } else {
     print('Indeks di luar rentang data!');
   }
   ```
2. **Pengecekan Ketersediaan Data Koleksi:**
   Sebelum mengakses elemen pertama atau terakhir, selalu pastikan koleksi tidak kosong menggunakan `mahasiswa.isNotEmpty`.
3. **Penggunaan Blok Penanganan Kesalahan (*Exception Handling*):**
   ```dart
   try {
     print(mahasiswa[5]);
   } on RangeError catch (e) {
     print('Terjadi kesalahan batas indeks: ${e.message}');
   }
   ```
4. **Membuat Extension Method *Safe Element Access*:**
   ```dart
   extension SafeList<T> on List<T> {
     T? elementAtOrNull(int index) =>
         (index >= 0 && index < length) ? this[index] : null;
   }
   // Pemanggilan: mahasiswa.elementAtOrNull(5) -> mengembalikan null secara aman
   ```

---

## BAGIAN N: PROBLEM SOLVING

### Soal:
Diberikan:
```dart
List<int> nilai = [80, 65, 90, 70, 95];
```
Tuliskan kode untuk mengambil nilai yang lebih besar atau sama dengan 80, kemudian hitung jumlah data yang memenuhi kondisi tersebut.

### Solusi Kode Dart:
```dart
void main() {
  List<int> nilai = [80, 65, 90, 70, 95];

  // 1. Mengambil data nilai yang >= 80 menggunakan where()
  var hasil = nilai.where((n) => n >= 80).toList();

  // 2. Menghitung jumlah data yang memenuhi kondisi
  int jumlah = hasil.length;

  // Alternatif one-liner tanpa alokasi list perantara:
  // int jumlah = nilai.where((n) => n >= 80).length;

  print('Nilai yang memenuhi (>= 80) : $hasil');
  print('Jumlah data yang memenuhi    : $jumlah');
}
```

### Hasil Eksekusi:
```text
Nilai yang memenuhi (>= 80) : [80, 90, 95]
Jumlah data yang memenuhi    : 3
```

---

## BAGIAN O: MINI PROJECT STUDENT MANAGEMENT APP

### Arsitektur Alur Aplikasi:
$$\text{Dashboard (Metrik)} \longrightarrow \text{Daftar Mahasiswa} \longrightarrow \text{Search / Filter / Sort} \longrightarrow \text{Tambah / Edit / Hapus (CRUD)}$$

### Rincian Fitur Utama:
1. **Dashboard Indikator Utama:**
   - **Total Mahasiswa:** Menampilkan jumlah seluruh mahasiswa yang tersimpan di dalam koleksi.
   - **Rata-rata IPK:** Menghitung rata-rata kumulatif seluruh mahasiswa secara presisi dengan format 2 digit desimal. Menangani kondisi khusus jika data kosong dengan nilai default `0.00`.
   - **Jumlah Mahasiswa Berprestasi (IPK $\ge 3.50$):** Menggunakan `where((m) => m.ipk >= 3.50).length`.
2. **Validasi Input Form yang Diterapkan:**
   - **NIM:** Wajib diisi, minimal 5 karakter, dan diverifikasi **unik** menggunakan fungsi `existsNim()`. Pengguna tidak dapat mendaftarkan NIM yang sudah ada di koleksi.
   - **Nama Lengkap:** Wajib diisi, minimal 2 karakter.
   - **Program Studi:** Wajib diisi.
   - **Semester:** Wajib diisi, divalidasi harus berupa bilangan bulat dalam rentang realistis perkuliahan universitas **1 sampai 14**.
   - **IPK:** Wajib diisi, divalidasi harus berupa angka desimal dalam rentang standar transkrip akademik nasional **0.00 sampai 4.00**.

---

## BAGIAN Q: CHECKLIST 10 INDIKATOR KEBERHASILAN PRAKTIKUM

Berdasarkan implementasi kode dan verifikasi nyata yang telah dilakukan, berikut adalah hasil pencocokan dengan **10 Indikator Keberhasilan Bagian Q**:

| No | Indikator Keberhasilan (LKM Bagian Q) | Status | Bukti Implementasi & Verifikasi Nyata |
| :-: | :--- | :-: | :--- |
| **1** | Project Flutter dapat dijalankan tanpa error | **TERPENUHI** | `flutter run -d chrome` berhasil diluncurkan dan terkoneksi (`Debug service listening on ws://127.0.0.1:54417/`). `flutter analyze` 0 issues. `flutter test` lulus 100% (28 tests: 26 unit tests + 2 widget tests pada viewport ponsel 390×844). |
| **2** | Data dapat ditampilkan dari List | **TERPENUHI** | Data mahasiswa, mata kuliah, dan barang berhasil dirender ke layar dari list koleksi in-memory. |
| **3** | Data baru dapat ditambahkan | **TERPENUHI** | Fitur "Tambah Data" berfungsi melalui dialog form modal dengan method `List.add()`. |
| **4** | Data dapat diedit | **TERPENUHI** | Fitur "Edit Data" memperbarui data objek mahasiswa/MK/barang dengan parameter `oldNim`/`oldKode` sehingga perubahan identifier utama terupdate sempurna. Teruji unit test. |
| **5** | Data dapat dihapus | **TERPENUHI** | Dialog konfirmasi hapus berhasil memicu `List.remove()` dan menampilkan SnackBar notifikasi. |
| **6** | Search berjalan dengan benar | **TERPENUHI** | Pencarian teks multi-atribut (NIM, Nama, Prodi, Semester, Kode, Dosen) bekerja seketika (*real-time*). |
| **7** | Sorting berjalan dengan benar | **TERPENUHI** | Sorting Nama A–Z, Nama Z–A, IPK, Semester, dan SKS (urutan naik) berjalan teruji dengan `sort()`. |
| **8** | ListView.builder digunakan untuk menampilkan data | **TERPENUHI** | Seluruh daftar koleksi dinamis (Mahasiswa, Mata Kuliah, Inventory) secara nyata menggunakan `ListView.builder` di dalam widget `Expanded`. |
| **9** | Perubahan data langsung terlihat pada UI | **TERPENUHI** | Pemanggilan `setState()` di setiap mutasi repository seketika memicu render ulang tampilan UI. |
| **10** | Mahasiswa dapat menjelaskan hubungan Collection, State, dan Widget | **TERPENUHI** | Dijelaskan secara komprehensif pada Bagian G, P, dan jawaban pertanyaan analisis Bagian L. |

---

## BAGIAN U: REFLEKSI MAHASISWA

> [!NOTE]
> *Draf refleksi ini disusun berdasarkan seluruh implementasi kode dan pengujian yang telah selesai dilaksanakan secara nyata. Anda dapat menyesuaikan gaya bahasa atau pengalaman pribadi sebelum menyerahkan tugas.*

- **Konsep baru yang saya pahami:**
  *Saya memahami secara mendalam cara kerja berbagai struktur koleksi data pada Dart (List, Set, dan Map), khususnya bagaimana higher-order methods seperti `where()` untuk penyaringan, `map()` untuk proyeksi transformasi elemen, dan `sort()` dengan custom comparator bekerja. Saya juga memahami bagaimana data objek di dalam List dihubungkan dengan siklus hidup widget Flutter melalui mekanisme `setState()` dan efisiensi memori yang ditawarkan oleh `ListView.builder`.*

- **Bagian praktikum yang paling sulit:**
  *Bagian yang paling membutuhkan ketelitian adalah merancang arsitektur filtering dan sorting multi-kriteria yang saling bersinergi (misalnya menggabungkan pencarian teks real-time dengan filter segmentasi IPK/SKS dan pengurutan dinamis), serta memastikan bahwa ringkasan statistik (seperti rata-rata IPK atau total SKS) bereaksi seketika terhadap data yang sedang tampil tanpa merusak data koleksi utama.*

- **Solusi yang saya lakukan:**
  *Saya memisahkan data master repository dari getter tampilan (`_dataTampil`). Logika filter dan pencarian diaplikasikan secara berurutan menggunakan chaining method koleksi Dart (`where()` dan `sort()`), kemudian seluruh kartu ringkasan metrik dikalkulasikan langsung dari hasil `_dataTampil` tersebut. Selain itu, saya memisahkan kode ke dalam pola arsitektur bersih (Model, Repository, dan UI).*

- **Fitur tambahan yang berhasil saya buat:**
  1. *Validasi form yang komprehensif: verifikasi keunikan NIM/kode, validasi batas semester (1–14), serta batas IPK (0.00–4.00).*
  2. *Challenge Kategori SKS pada Mata Kuliah dengan kartu ringkasan dinamis (Jumlah MK, Total SKS, dan Rata-rata SKS) yang reaktif mengikuti filter dan pencarian.*
  3. *Modul Pengayaan Inventory Barang lengkap dengan perhitungan nilai tiap barang ($\text{stok} \times \text{harga}$) dan total persediaan gudang berformat mata uang Rupiah.*
  4. *Shell navigasi responsif yang mendukung tampilan mobile (`NavigationBar`) dan desktop/tablet (`NavigationRail`).*

- **Kesimpulan pembelajaran hari ini:**
  *Pengelolaan koleksi data merupakan fondasi mutlak dalam pemrograman aplikasi mobile. Tanpa pemahaman yang kokoh mengenai manipulasi List dan siklus rendering state pada Flutter, pembuatan aplikasi dinamis yang interaktif tidak dapat terwujud. Penerapan pola Repository sejak dini mempermudah pengembangan aplikasi ke tingkat lanjut.*

---

## BAGIAN V: ARSITEKTUR PEMISAHAN KODE & RENCANA TRANSISI KE DATABASE / REST API

Pada proyek ini, arahan bagian V diwujudkan melalui penerapan **Clean Layered Architecture** dengan memisahkan kode menjadi 3 lapisan independen:
1. **Lapisan Model (`lib/models/`):** Berisi definisi entitas murni (`Mahasiswa`, `MataKuliah`, `Barang`).
2. **Lapisan Logika & Data Access (`lib/repositories/`):** Menggunakan antarmuka abstrak (`MahasiswaRepository`, dll.) dan kelas implementasi konkret.
3. **Lapisan Presentasi / UI (`lib/pages/` dan `lib/widgets/`):** Widget Flutter hanya berinteraksi dengan antarmuka repository.

### Rencana Transisi Menuju Database Lokal / REST API:
Saat ini, aplikasi menggunakan implementasi in-memory list:
```dart
class InMemoryMahasiswaRepository implements MahasiswaRepository { ... }
```

Kelak, jika aplikasi dihubungkan dengan database lokal (misalnya **SQLite / sqflite**) atau **REST API backend**, pengembang **hanya perlu membuat kelas implementasi baru** tanpa perlu mengubah satu baris pun kode antarmuka UI:

```dart
// Contoh Implementasi Masa Depan dengan REST API (HTTP Client)
class RestApiMahasiswaRepository implements MahasiswaRepository {
  final http.Client httpClient;
  final String baseUrl;

  RestApiMahasiswaRepository({required this.httpClient, required this.baseUrl});

  @override
  List<Mahasiswa> getAll() {
    // Memanggil GET /api/mahasiswa dan mem-parsing JSON response
    ...
  }
  // Implementasi method lainnya sesuai kontrak interface
}
```

> **Catatan Kejujuran Teknis:** Sesuai instruksi LKM dan pengguna, fitur database eksternal / REST API belum dihubungkan saat ini karena materi praktikum difokuskan pada penguasaan koleksi data in-memory di Dart.

---

## LAMPIRAN: BUKTI VERIFIKASI EKSEKUSI PROGRAM NYATA

### 1. Eksekusi Script Dart Praktikum Dasar 1–9
Perintah: `dart run bin/praktikum_dasar.dart`
Status: **EXIT CODE 0 (SUKSES)**
Ringkasan Hasil:
- Praktikum 1: `[Ahmad, Budi, Citra, Dewi]`
- Praktikum 2: `[0]` = Ahmad, `first` = Ahmad, `length` = 4
- Praktikum 3: Duplikasi terbukti `[Ahmad, Budi, Citra, Dewi, Citra, Dewi, Eka, Farhan]`
- Praktikum 4: Indeks 1 terbukti berubah menjadi `Budi Santoso`
- Praktikum 5: `clear()` mengosongkan list (`length = 0`)
- Praktikum 6: 3 variasi iterasi (`for`, `for-in`, `forEach`) berhasil dijalankan dengan langkah tambahan
- Praktikum 7: Filter `startsWith('A')` menghasilkan `[Ahmad, Andi, Anisa]`
- Praktikum 8: Transformasi `toUpperCase()` menghasilkan `[AHMAD, BUDI, ANDI, CITRA, ANISA]`
- Praktikum 9: Sorting A-Z dan descending Z-A terverifikasi sempurna

### 2. Eksekusi Script Dart Eksplorasi Koleksi & Problem Solving
Perintah: `dart run bin/eksplorasi_collection.dart`
Status: **EXIT CODE 0 (SUKSES)**
Ringkasan Hasil:
- Jumlah data: 7
- Nilai tertinggi: 95
- Nilai terendah: 65
- Rata-rata: 80.00
- Nilai $\ge 80$: `[80, 90, 85, 95]`
- Nilai $< 80$: `[75, 65, 70]`
- Ascending: `[65, 70, 75, 80, 85, 90, 95]`
- Descending: `[95, 90, 85, 80, 75, 70, 65]`
- Problem Solving Bagian N: Filter $\ge 80$ menghasilkan `[80, 90, 95]` dengan jumlah 3 data.

### 3. Analisis Kode Statis Flutter
Perintah: `flutter analyze`
Status: **EXIT CODE 0 (SUKSES)**
Output: `Analyzing tugas 2... No issues found! (ran in 1.3s)`
Tidak ada error, warning, maupun lint issue.

### 4. Pengujian Otomatis Unit & Widget
Perintah: `flutter test`
Status: **100% LULUS (28 DARI 28 PENGUJIAN)**
Output:
```text
00:05 +28: All tests passed!
```
Rincian Pengujian:
1. **26 Unit Tests (`test/collection_logic_test.dart`):** Mencakup pengujian logika manipulasi koleksi Dart, operasi CRUD Mahasiswa, Mata Kuliah, Barang, validasi perubahan NIM/Kode lama ke baru, filtering IPK & tantangan SKS, kalkulasi nilai persediaan, serta pengurutan data (*sorting*).
2. **2 Widget Tests (`test/widget_test.dart`):**
   - **Bebas Exception pada Ponsel 390×844:** Memverifikasi seluruh 4 tab aplikasi (Mahasiswa, Mata Kuliah, Inventory, Eksplorasi) berjalan sempurna tanpa error, tanpa exception, dan bebas dari *RenderFlex overflow* pada viewport ponsel standar 390×844.
   - **Alur CRUD Lengkap:** Memverifikasi interaksi pengguna mulai dari menambahkan mahasiswa baru, mengedit data (termasuk memperbarui NIM lama ke baru), hingga menghapus mahasiswa melalui dialog konfirmasi pada viewport ponsel.

### 5. Eksekusi Nyata Aplikasi Flutter (Runtime Execution)
Perintah: `flutter run -d chrome`
Status: **BERHASIL DILUNCURKAN DAN TERHUBUNG (RUNNING TANPA ERROR)**
Log Eksekusi Nyata:
```text
Launching lib\main.dart on Chrome in debug mode...
Waiting for connection from debug service on Chrome...             15.4s
This app is linked to the debug service: ws://127.0.0.1:54417/71NFmcxqwsY=/ws
Debug service listening on ws://127.0.0.1:54417/71NFmcxqwsY=/ws
A Dart VM Service on Chrome is available at: http://127.0.0.1:54417/71NFmcxqwsY=
The Flutter DevTools debugger and profiler on Chrome is available at: http://127.0.0.1:54417/71NFmcxqwsY=/devtools/?uri=ws://127.0.0.1:54417/71NFmcxqwsY=/ws
Starting application from main method in: org-dartlang-app:///web_entrypoint.dart.
```
Aplikasi terbukti berjalan secara interaktif di browser Chrome dengan hot reload aktif.

### 6. Verifikasi Kompilasi Web Production
Perintah: `flutter build web`
Status: **EXIT CODE 0 (SUKSES)**
Output:
```text
Compiling lib\main.dart for the Web...                             39.7s
√ Built build\web
```
Menjamin seluruh berkas dart terkompilasi penuh tanpa ada kendala sintaksis atau dependensi.
