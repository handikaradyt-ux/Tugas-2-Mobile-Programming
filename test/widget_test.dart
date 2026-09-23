import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_2_collection/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Aplikasi berjalan tanpa exception pada viewport ponsel 390x844 di seluruh tab', (WidgetTester tester) async {
    // Set ukuran layar ponsel standar iPhone 12/13/14 (390 x 844)
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // 1. Tab Mahasiswa (Default)
    expect(find.text('LKM Koleksi Flutter'), findsOneWidget);
    expect(find.text('Data Mahasiswa'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(tester.takeException(), isNull);

    // 2. Beralih ke Tab Mata Kuliah
    await tester.tap(find.text('Mata Kuliah'));
    await tester.pumpAndSettle();
    expect(find.text('Data Mata Kuliah'), findsOneWidget);
    expect(find.text('Semua SKS'), findsNothing); // label is 'Semua'
    expect(tester.takeException(), isNull);

    // 3. Beralih ke Tab Inventory
    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();
    expect(find.text('Inventory Barang'), findsOneWidget);
    expect(find.text('Total Persediaan'), findsOneWidget);
    expect(tester.takeException(), isNull);

    // 4. Beralih ke Tab Eksplorasi Koleksi
    await tester.tap(find.text('Eksplorasi'));
    await tester.pumpAndSettle();
    expect(find.text('Eksplorasi Koleksi Dart (Bagian I & N)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Alur lengkap Tambah, Edit (termasuk NIM), dan Hapus mahasiswa pada ukuran ponsel 390x844', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Pastikan berada di tab Mahasiswa
    expect(find.text('Data Mahasiswa'), findsOneWidget);

    // --- ALUR 1: TAMBAH MAHASISWA BARU ---
    await tester.tap(find.byKey(const Key('btn_tambah_mahasiswa')));
    await tester.pumpAndSettle();

    // Isi formulir
    await tester.enterText(find.byKey(const Key('input_nim')), '23010099');
    await tester.enterText(find.byKey(const Key('input_nama')), 'AA Zulfa Maharani');
    await tester.enterText(find.byKey(const Key('input_prodi')), 'Teknik Informatika');
    await tester.enterText(find.byKey(const Key('input_semester')), '5');
    await tester.enterText(find.byKey(const Key('input_ipk')), '3.90');

    // Simpan data
    await tester.tap(find.byKey(const Key('btn_simpan_mahasiswa')));
    await tester.pumpAndSettle();

    // Verifikasi data baru muncul di daftar
    expect(find.text('AA Zulfa Maharani'), findsOneWidget);
    expect(find.textContaining('23010099'), findsOneWidget);

    // --- ALUR 2: EDIT MAHASISWA (TERMASUK MENGUBAH NIM) ---
    // Cari tombol edit pada kartu AA Zulfa Maharani
    final editButtonFinder = find.descendant(
      of: find.ancestor(
        of: find.text('AA Zulfa Maharani'),
        matching: find.byType(Card),
      ),
      matching: find.byIcon(Icons.edit),
    );
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle();

    // Ubah NIM ke '23010888' dan Nama ke 'AA Zulfa Maharani S.Kom'
    await tester.enterText(find.byKey(const Key('input_nim')), '23010888');
    await tester.enterText(find.byKey(const Key('input_nama')), 'AA Zulfa Maharani S.Kom');
    await tester.enterText(find.byKey(const Key('input_ipk')), '3.95');

    // Simpan pembaruan
    await tester.tap(find.byKey(const Key('btn_simpan_mahasiswa')));
    await tester.pumpAndSettle();

    // Verifikasi data terupdate dan NIM baru tersimpan
    expect(find.text('AA Zulfa Maharani S.Kom'), findsOneWidget);
    expect(find.textContaining('23010888'), findsOneWidget);
    expect(find.text('AA Zulfa Maharani'), findsNothing);

    // --- ALUR 3: HAPUS MAHASISWA DENGAN KONFIRMASI ---
    final deleteButtonFinder = find.descendant(
      of: find.ancestor(
        of: find.text('AA Zulfa Maharani S.Kom'),
        matching: find.byType(Card),
      ),
      matching: find.byIcon(Icons.delete_outline),
    );
    await tester.tap(deleteButtonFinder);
    await tester.pumpAndSettle();

    // Verifikasi dialog konfirmasi muncul
    expect(find.text('Hapus Mahasiswa'), findsOneWidget);
    expect(find.text('Hapus'), findsOneWidget);

    // Konfirmasi hapus
    await tester.tap(find.text('Hapus'));
    await tester.pumpAndSettle();

    // Verifikasi data berhasil dihapus dari UI
    expect(find.text('AA Zulfa Maharani S.Kom'), findsNothing);
    expect(find.textContaining('23010888'), findsNothing);
  });
}
