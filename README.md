# Tugas 2 Mobile Programming: Pengelolaan Data List & Koleksi dengan Flutter dan Dart

Proyek ini dibangun berdasarkan dokumen **Lembar Kerja Mahasiswa (LKM) Mengelola Data List atau Koleksi dengan Flutter dan Dart Programming**. Proyek mengimplementasikan seluruh materi mulai dari dasar koleksi Dart hingga aplikasi terstruktur dengan arsitektur bersih (*Clean Architecture*).

---

## 📁 Struktur Direktori Proyek

```
tugas_2/
├── bin/
│   ├── praktikum_dasar.dart              # Skrip CLI Praktikum 1–9 dengan isolasi scope
│   └── eksplorasi_collection.dart        # Skrip CLI 8 tugas Bagian I & Problem Solving N
├── lib/
│   ├── main.dart                         # Entry point aplikasi Flutter (Material 3 Theme)
│   ├── models/
│   │   ├── mahasiswa.dart                # Model Mahasiswa (nim, nama, prodi, semester, ipk)
│   │   ├── mata_kuliah.dart              # Model MataKuliah (kode, nama, sks, dosen)
│   │   └── barang.dart                   # Model Barang (kode, nama, stok, harga, nilaiTotal)
│   ├── repositories/
│   │   ├── mahasiswa_repository.dart     # Interface & In-Memory List repository Mahasiswa
│   │   ├── mata_kuliah_repository.dart   # Interface & In-Memory List repository Mata Kuliah
│   │   └── barang_repository.dart        # Interface & In-Memory List repository Barang
│   ├── pages/
│   │   ├── home_page.dart                # Shell Navigasi (NavigationRail & NavigationBar)
│   │   ├── mahasiswa_page.dart           # Dashboard, Search, Filter IPK, Sort, CRUD (ListView.builder)
│   │   ├── mata_kuliah_page.dart         # SKS Filter Challenge, Ringkasan Dinamis, Sort (ListView.builder)
│   │   ├── inventory_page.dart           # Inventory Barang, Kalkulasi Nilai Persediaan (ListView.builder)
│   │   └── collection_exploration_page.dart # GUI visualisasi interaktif 8 tugas nilai & problem solving
│   └── widgets/
│       ├── stat_card.dart                # Widget kartu metrik statistik reusable
│       └── confirm_dialog.dart           # Dialog konfirmasi hapus data reusable
├── test/
│   ├── collection_logic_test.dart        # 26 Unit tests untuk logika koleksi, repo, update NIM/kode, filter, sort
│   └── widget_test.dart                  # Widget test memverifikasi rendering UI aplikasi
├── JAWABAN_LKM.md                        # Dokumen resmi jawaban tertulis lengkap LKM (Bagian 1 s.d. V)
└── README.md                             # Panduan instalasi, eksekusi, dan pengujian proyek
```

---

## 🚀 Persyaratan Sistem & Panduan Menjalankan Program

### Persyaratan Lingkungan Pengembangan (*Environment Prerequisites*)
Sesuai dengan konfigurasi pada `pubspec.yaml`:
- **Dart SDK:** Versi `^3.13.2` (Dart $\ge$ 3.13.2 dan $<$ 4.0.0, teruji pada Dart 3.13.2).
- **Flutter Framework:** Versi $\ge$ 3.24.0 (teruji dan diverifikasi pada Flutter 3.47.2 channel stable).
> **Catatan Penting:** Versi Dart SDK tidak disamakan dengan versi Flutter Framework. `pubspec.yaml` mendefinisikan batasan `environment: sdk: ^3.13.2` yang merujuk secara khusus kepada Dart SDK.

---

### 1. Menjalankan Skrip CLI Praktikum Dasar 1–9
Skrip ini mendemonstrasikan pembuatan List, pengaksesan elemen, penambahan (`add`/`addAll`), modifikasi elemen indeks 1, penghapusan (`clear`), iterasi (`for`, `for-in`, `forEach`), filtering `where()`, transformasi `map()`, dan sorting.

```bash
dart run bin/praktikum_dasar.dart
```

### 2. Menjalankan Skrip CLI Eksplorasi Koleksi & Problem Solving
Skrip ini menghitung 8 tugas statistik nilai (`[75, 80, 90, 65, 85, 95, 70]`) dan solusi soal Bagian N (`[80, 65, 90, 70, 95]`):

```bash
dart run bin/eksplorasi_collection.dart
```

### 3. Menjalankan Analisis Statis Kode (*Static Analysis*)
Memverifikasi bahwa kode bebas dari error, warning, dan lint issues (`0 issues found`):

```bash
flutter analyze
```

### 4. Menjalankan Seluruh Pengujian Otomatis (*Unit & Widget Tests*)
Menjalankan **28 pengujian otomatis** (`28 passed, 0 failed`) yang terdiri dari:
1. **26 Unit Tests (`test/collection_logic_test.dart`):** Pengujian logika manipulasi koleksi, operasi CRUD repository, validasi keunikan dan perubahan identitas NIM/Kode, filtering IPK & SKS, kalkulasi inventaris, dan pengurutan (*sorting*).
2. **2 Widget Tests (`test/widget_test.dart`):**
   - Verifikasi bahwa aplikasi berjalan **tanpa exception maupun RenderFlex overflow** pada viewport ponsel standar (**390×844**) di seluruh 4 tab aplikasi.
   - Verifikasi alur pengguna penuh: **Tambah mahasiswa baru**, **Edit mahasiswa** (termasuk validasi dan pembaruan perubahan NIM lama ke NIM baru), serta **Hapus mahasiswa** dengan dialog konfirmasi.

```bash
flutter test
```

### 5. Menjalankan Aplikasi Flutter Secara Interaktif
Aplikasi telah diverifikasi berhasil diluncurkan menggunakan browser Chrome:

```bash
# Menjalankan di Chrome (Web Browser):
flutter run -d chrome

# Menjalankan di Windows Desktop (bila visual studio toolchain terpasang):
flutter run -d windows
```

---

## 🌟 Fitur dan Modul Aplikasi

### 1. Modul Manajemen Mahasiswa (Student Management App)
- **Dashboard Metrik:** Menampilkan Total Mahasiswa, Rata-rata IPK (2 desimal), dan Jumlah Mahasiswa Berprestasi (IPK $\ge 3.50$).
- **ListView.builder:** Menampilkan daftar kartu mahasiswa dengan avatar, badge semester, chip IPK, tombol edit, dan tombol hapus.
- **Pencarian Multi-Kolom:** Pencarian real-time berdasarkan NIM, nama lengkap, prodi, dan semester.
- **Filter Segmentasi IPK:** Filter cepat "Semua", "IPK $\ge 3.50$", dan "IPK $< 3.50$".
- **Sorting Fleksibel:** Pengurutan Nama A–Z, Nama Z–A, IPK Tertinggi, IPK Terendah, dan Semester.
- **Form CRUD Tervalidasi:** Dialog penambahan dan pengeditan dengan validasi wajib isi, batas semester (1–14), batas IPK (0.00–4.00), serta verifikasi keunikan NIM (termasuk saat pergantian NIM lama ke NIM baru).
- **Konfirmasi Penghapusan:** Dialog konfirmasi sebelum menghapus data untuk mencegah kesalahan pengguna.

### 2. Modul Mata Kuliah & Challenge Kategori SKS
- **ListView.builder:** Menampilkan daftar mata kuliah dengan kode, nama, bobot SKS, dan dosen pengampu.
- **Pencarian Real-Time:** Filter berdasarkan kode mata kuliah, nama, atau dosen.
- **Sorting SKS Urutan Naik:** Sesuai instruksi, pengurutan SKS menggunakan urutan naik (*Ascending*: 2 SKS $\rightarrow$ 3 SKS $\rightarrow$ 4 SKS).
- **Challenge Filter Kategori SKS:** Filter chip "Semua", "2 SKS", "3 SKS", dan "4 SKS" menggunakan `where()`.
- **Ringkasan Dinamis Reaktif:** Kartu metrik Jumlah MK Tampil, Total SKS Tampil, dan Rata-rata SKS dihitung langsung dari data yang sedang aktif/tampil (`_dataTampil`), sehingga bereaksi seketika terhadap filter dan pencarian.
- **Form CRUD Tervalidasi:** Menjamin keunikan kode mata kuliah saat menambah maupun mengedit.

### 3. Modul Pengayaan Inventory Barang
- **Perhitungan Nilai Barang:** Menghitung nilai tiap barang secara otomatis dengan rumus $\text{stok} \times \text{harga}$.
- **Total Persediaan Gudang:** Menghitung total nilai seluruh stok persediaan $\sum (\text{stok} \times \text{harga})$ berformat mata uang Rupiah.
- **ListView.builder:** Menampilkan data inventaris barang secara efisien.
- **CRUD & Pencarian:** Menambah, mengedit kode/nama/stok/harga, dan menghapus barang dengan konfirmasi.

### 4. Modul Eksplorasi Koleksi Interaktif
- Visualisasi GUI interaktif untuk menguji 8 tugas eksplorasi statistik nilai (Min, Max, Rata-rata, $\ge 80$, $< 80$, Ascending, Descending) dan problem solving Bagian N.

---

## 📐 Arsitektur & Kesiapan Masa Depan (Bagian V)
Aplikasi memisahkan model data murni (`lib/models/`), lapisan antarmuka repository (`lib/repositories/`), dan antarmuka visual (`lib/pages/`). Implementasi saat ini menggunakan in-memory List murni (`InMemoryMahasiswaRepository`, dll.). Di masa depan, lapisan ini dapat ditukar ke **SQLite** atau **REST API** tanpa mengubah kode UI.

---

## 📄 Dokumen Jawaban LKM
Seluruh pembahasan teoretis, analisis kesalahan program, jawaban 10 pertanyaan Bagian L, dan refleksi dapat dibaca pada berkas **[`JAWABAN_LKM.md`](./JAWABAN_LKM.md)**.
