# DAFTAR BUKTI TANGKAPAN LAYAR (SCREENSHOT)
## Lembar Kerja Mahasiswa (LKM): Mengelola Data List atau Koleksi dengan Flutter dan Dart

Dokumen ini memetakan 35 gambar bukti ke bagian serta fitur yang relevan pada LKM. Bukti aplikasi Flutter diambil pada viewport ponsel 390×844. Bukti terminal menampilkan keluaran perintah yang dijalankan, lalu divisualisasikan sebagai tampilan terminal untuk pengambilan gambar.

Seluruh file gambar tersimpan pada direktori: `bukti_screenshot/`

---

## 1. Bukti Eksekusi Terminal CLI (Dart & Flutter)

| No | Nama File Screenshot | Perintah Terminal | Bagian LKM | Fitur & Indikator yang Dibuktikan |
| :-: | :--- | :--- | :--- | :--- |
| **T01** | `terminal_praktikum_1_4.png` | `dart run bin/praktikum_dasar.dart` | Bagian D (Praktikum 1–4) | - Pembuatan List mahasiswa 4 elemen.<br>- Pengaksesan elemen via indeks `[0]` dan getter `.first`, `.last`, `.length`, `.isEmpty`.<br>- Penambahan data `add()` dan `addAll()` yang membuktikan duplikasi nama `Citra` dan `Dewi` pada List.<br>- Pengubahan elemen indeks ke-1 menjadi `Budi Santoso` (*zero-based indexing*). |
| **T02** | `terminal_praktikum_5_6.png` | `dart run bin/praktikum_dasar.dart` | Bagian D (Praktikum 5–6) | - Penghapusan data dengan `remove()`, `removeAt()`, `removeLast()`, dan pengosongan list dengan `clear()` (`length: 0`).<br>- Pembuktian bahwa iterasi pada list kosong tidak mencetak nama.<br>- Langkah tambahan inisialisasi ulang list untuk demonstrasi 3 variasi iterasi (`for`, `for-in`, dan `forEach`). |
| **T03** | `terminal_praktikum_7_9.png` | `dart run bin/praktikum_dasar.dart` | Bagian D (Praktikum 7–9) | - Penyaringan data berawalan huruf 'A' menggunakan `where()`.<br>- Transformasi huruf kapital menggunakan `map()` tanpa memodifikasi list sumber.<br>- Pengurutan data alfabetis naik (A–Z) dengan `sort()` dan turun (Z–A) dengan `reversed.toList()`. |
| **T04** | `terminal_eksplorasi_bagian_i_n.png` | `dart run bin/eksplorasi_collection.dart` | Bagian I & Bagian N | - Perhitungan 8 tugas statistik nilai `[75, 80, 90, 65, 85, 95, 70]`: jumlah data (7), nilai tertinggi (95), nilai terendah (65), rata-rata (80.00), nilai $\ge 80$ (4 data), nilai $< 80$ (3 data), ascending, dan descending.<br>- Solusi Problem Solving Bagian N `[80, 65, 90, 70, 95]`: filter $\ge 80$ menghasilkan `[80, 90, 95]` dengan jumlah 3 data. |
| **T05** | `terminal_flutter_analyze.png` | `flutter analyze` | Bagian Q (Indikator 1) & Lampiran | - Memverifikasi bahwa seluruh basis kode proyek Flutter dan Dart bersih dari error, warning, dan lint issue (**No issues found!**). |
| **T06** | `terminal_flutter_test.png` | `flutter test` | Bagian Q (Indikator 1, 4, 8) & Lampiran | - Memverifikasi keberhasilan eksekusi **28 otomatis pengujian** (100% lulus): 26 unit test logika koleksi, repository CRUD, validasi perubahan NIM/Kode, filtering, sorting, serta 2 widget test pada viewport ponsel 390×844. |

---

## 2. Bukti Antarmuka Aplikasi Mahasiswa (Viewport Ponsel 390×844)

| No | Nama File Screenshot | URL / Parameter Pengujian | Bagian LKM | Fitur & Indikator yang Dibuktikan |
| :-: | :--- | :--- | :--- | :--- |
| **M01** | `app_mahasiswa_dashboard_daftar.png` | `http://localhost:8088/?tab=0` | Bagian O & Bagian Q (Indikator 2, 8) | - Tampilan dashboard metrik (Total Mahasiswa: 6 Mhs, Rata-rata IPK: 3.49, Mahasiswa Berprestasi: 3 Mhs).<br>- Daftar kartu mahasiswa menggunakan `ListView.builder` dalam viewport ponsel (390×844) bebas overflow. |
| **M02** | `app_mahasiswa_tambah_dialog.png` | `http://localhost:8088/?tab=0&m_action=tambah` | Bagian O & Bagian Q (Indikator 3) | - Dialog modal form tambah mahasiswa baru dengan field NIM, Nama Lengkap, Program Studi, Semester, dan IPK yang responsif dan tervalidasi. |
| **M03** | `app_mahasiswa_tambah_hasil.png` | `http://localhost:8088/?tab=0&m_action=added_sample` | Bagian O & Bagian Q (Indikator 3, 9) | - Hasil penambahan data mahasiswa baru (Zulfa Maharani, NIM 23010099, IPK 3.90) yang seketika merender ulang UI dan memperbarui metrik total mahasiswa. |
| **M04** | `app_mahasiswa_edit_dialog.png` | `http://localhost:8088/?tab=0&m_action=edit` | Bagian O & Bagian Q (Indikator 4) | - Dialog modal form edit data mahasiswa yang memuat data lama dan mengizinkan pembaruan NIM, Nama, Prodi, Semester, maupun IPK. |
| **M05** | `app_mahasiswa_edit_hasil.png` | `http://localhost:8088/?tab=0&m_action=edited_sample` | Bagian O & Bagian Q (Indikator 4, 9) | - Hasil pembaruan data mahasiswa (Ahmad Fauzi S.Kom, IPK 3.95) yang terbukti memperbarui record lama tanpa membuat data ganda. |
| **M06** | `app_mahasiswa_delete_dialog.png` | `http://localhost:8088/?tab=0&m_action=delete` | Bagian O & Bagian Q (Indikator 5) | - Dialog konfirmasi sebelum menghapus data untuk mencegah penghapusan data secara tidak sengaja oleh pengguna. |
| **M07** | `app_mahasiswa_delete_hasil.png` | `http://localhost:8088/?tab=0&m_action=deleted_sample` | Bagian O & Bagian Q (Indikator 5, 9) | - Tampilan daftar dan dashboard metrik setelah data dihapus, membuktikan pembaruan UI seketika (*reactive state*). |
| **M08** | `app_mahasiswa_search.png` | `http://localhost:8088/?tab=0&m_search=fauzi` | Bagian O & Bagian Q (Indikator 6) | - Fitur pencarian multi-kolom real-time (keyword: `fauzi`) yang menyaring daftar seketika sesuai kriteria pencarian. |
| **M09** | `app_mahasiswa_filter_cumlaude.png` | `http://localhost:8088/?tab=0&m_filter=IPK ≥ 3.50` | Bagian H (Latihan 3) & Bagian O | - Filter segmentasi kategori mahasiswa berprestasi dengan IPK $\ge 3.50$ menggunakan method `where()`. |
| **M10** | `app_mahasiswa_filter_non_cumlaude.png` | `http://localhost:8088/?tab=0&m_filter=IPK < 3.50` | Bagian H (Latihan 3) & Bagian O | - Filter segmentasi mahasiswa dengan IPK $< 3.50$ menggunakan method `where()`. |
| **M11** | `app_mahasiswa_sort_nama_za.png` | `http://localhost:8088/?tab=0&m_sort=Nama Z-A` | Bagian H (Latihan 4) & Bagian Q (7) | - Pengurutan daftar mahasiswa berdasarkan Nama secara menurun (*descending* Z–A). |
| **M12** | `app_mahasiswa_sort_ipk_tertinggi.png` | `http://localhost:8088/?tab=0&m_sort=IPK Tertinggi` | Bagian H (Latihan 4) & Bagian Q (7) | - Pengurutan daftar mahasiswa berdasarkan IPK dari yang tertinggi ke terendah (*descending*). |
| **M13** | `app_mahasiswa_sort_ipk_terendah.png` | `http://localhost:8088/?tab=0&m_sort=IPK Terendah` | Bagian H (Latihan 4) & Bagian Q (7) | - Pengurutan daftar mahasiswa berdasarkan IPK dari yang terendah ke tertinggi (*ascending*). |
| **M14** | `app_mahasiswa_sort_semester.png` | `http://localhost:8088/?tab=0&m_sort=Semester` | Bagian H (Latihan 4) & Bagian Q (7) | - Pengurutan daftar mahasiswa berdasarkan semester secara berurutan. |

---

## 3. Bukti Antarmuka Aplikasi Mata Kuliah (Viewport Ponsel 390×844)

| No | Nama File Screenshot | URL / Parameter Pengujian | Bagian LKM | Fitur & Indikator yang Dibuktikan |
| :-: | :--- | :--- | :--- | :--- |
| **K01** | `app_matakuliah_daftar_ringkasan.png` | `http://localhost:8088/?tab=1` | Bagian J & Challenge | - Tampilan daftar mata kuliah dengan `ListView.builder` dan kartu ringkasan dinamis: Jumlah MK (6 MK), Total SKS (17 SKS), dan Rata-rata SKS (2.83). |
| **K02** | `app_matakuliah_tambah_dialog.png` | `http://localhost:8088/?tab=1&mk_action=tambah` | Bagian J (Poin 2) | - Dialog modal form tambah mata kuliah dengan validasi kode unik, nama, bobot SKS (1–6), dan dosen pengampu. |
| **K03** | `app_matakuliah_edit_dialog.png` | `http://localhost:8088/?tab=1&mk_action=edit` | Bagian J (Poin 3) | - Dialog modal form edit mata kuliah dengan dukungan pembaruan kode mata kuliah lama ke kode baru. |
| **K04** | `app_matakuliah_delete_dialog.png` | `http://localhost:8088/?tab=1&mk_action=delete` | Bagian J (Poin 4, 5) | - Dialog konfirmasi sebelum menghapus mata kuliah dari daftar koleksi. |
| **K05** | `app_matakuliah_search.png` | `http://localhost:8088/?tab=1&mk_search=mobile` | Bagian J (Poin 6) | - Pencarian mata kuliah berdasarkan nama, kode, atau dosen pengampu (keyword: `mobile`). |
| **K06** | `app_matakuliah_sort_sks.png` | `http://localhost:8088/?tab=1&mk_sort=SKS (Urutan Naik)` | Bagian J (Poin 10) | - Pengurutan mata kuliah berdasarkan bobot SKS dalam urutan naik (*ascending*: 2 SKS $\rightarrow$ 3 SKS $\rightarrow$ 4 SKS). |
| **K07** | `app_matakuliah_filter_2sks.png` | `http://localhost:8088/?tab=1&mk_filter=2 SKS` | Challenge Bagian J | - Filter kategori 2 SKS via `where()`, ringkasan dinamis ter-update seketika: **2 MK**, **4 SKS**, Rata-rata **2.00 SKS**. |
| **K08** | `app_matakuliah_filter_3sks.png` | `http://localhost:8088/?tab=1&mk_filter=3 SKS` | Challenge Bagian J | - Filter kategori 3 SKS via `where()`, ringkasan dinamis ter-update seketika: **3 MK**, **9 SKS**, Rata-rata **3.00 SKS**. |
| **K09** | `app_matakuliah_filter_4sks.png` | `http://localhost:8088/?tab=1&mk_filter=4 SKS` | Challenge Bagian J | - Filter kategori 4 SKS via `where()`, ringkasan dinamis ter-update seketika: **1 MK**, **4 SKS**, Rata-rata **4.00 SKS**. |

---

## 4. Bukti Antarmuka Inventory Barang & Eksplorasi Koleksi

| No | Nama File Screenshot | URL / Parameter Pengujian | Bagian LKM | Fitur & Indikator yang Dibuktikan |
| :-: | :--- | :--- | :--- | :--- |
| **I01** | `app_inventory_daftar_total.png` | `http://localhost:8088/?tab=2` | Bagian K (Inventory) | - Tampilan daftar barang dengan `ListView.builder`.<br>- Perhitungan otomatis nilai tiap barang: $\text{stok} \times \text{harga}$.<br>- Perhitungan total nilai seluruh persediaan gudang: $\sum(\text{stok} \times \text{harga}) = \text{Rp } 210.300.000$. |
| **I02** | `app_inventory_tambah_dialog.png` | `http://localhost:8088/?tab=2&inv_action=tambah` | Bagian K (Inventory) | - Form tambah barang baru dengan kode, nama, stok unit, dan harga satuan berformat Rupiah. |
| **I03** | `app_inventory_edit_dialog.png` | `http://localhost:8088/?tab=2&inv_action=edit` | Bagian K (Inventory) | - Form edit data barang dengan dukungan pengubahan kode barang lama ke kode baru. |
| **I04** | `app_inventory_delete_dialog.png` | `http://localhost:8088/?tab=2&inv_action=delete` | Bagian K (Inventory) | - Dialog konfirmasi sebelum menghapus barang inventaris. |
| **I05** | `app_inventory_search.png` | `http://localhost:8088/?tab=2&inv_search=asus` | Bagian K (Inventory) | - Pencarian barang secara real-time berdasarkan kode atau nama barang (keyword: `asus`). |
| **E01** | `app_eksplorasi_collection.png` | `http://localhost:8088/?tab=3` | Bagian I & Bagian N | - Visualisasi GUI interaktif untuk perhitungan 8 tugas statistik nilai dan Problem Solving Bagian N di dalam aplikasi Flutter. |
