import 'package:flutter/material.dart';
import '../models/barang.dart';
import '../repositories/barang_repository.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/stat_card.dart';

class InventoryPage extends StatefulWidget {
  final BarangRepository repository;

  const InventoryPage({super.key, required this.repository});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  String _keyword = '';
  final TextEditingController _searchController = TextEditingController();

  List<Barang> get _dataTampil {
    return widget.repository.getFiltered(keyword: _keyword);
  }

  // Ringkasan Persediaan (Bagian K LKM)
  int get _totalJenisBarang => widget.repository.getAll().length;

  int get _totalUnitStok {
    final all = widget.repository.getAll();
    if (all.isEmpty) return 0;
    return all.map((b) => b.stok).reduce((a, b) => a + b);
  }

  double get _totalPersediaanSemua {
    return widget.repository.hitungTotalPersediaan(widget.repository.getAll());
  }

  double get _totalPersediaanTampil {
    return widget.repository.hitungTotalPersediaan(_dataTampil);
  }

  static String formatRupiah(num nominal) {
    List<String> parts = nominal.toStringAsFixed(0).split('.');
    RegExp re = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    parts[0] = parts[0].replaceAllMapped(re, (Match m) => '${m[1]}.');
    return 'Rp ${parts[0]}';
  }

  void _tambahData() {
    _showFormBarangDialog();
  }

  void _editData(Barang barang) {
    _showFormBarangDialog(barang: barang);
  }

  Future<void> _hapusData(Barang barang) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: 'Hapus Barang',
      message: 'Apakah Anda yakin ingin menghapus barang "${barang.nama}" (${barang.kode})?',
    );

    if (confirmed == true && mounted) {
      setState(() {
        widget.repository.delete(barang);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${barang.nama} berhasil dihapus'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showFormBarangDialog({Barang? barang}) {
    final isEdit = barang != null;
    final String? oldKode = barang?.kode;
    final formKey = GlobalKey<FormState>();

    final kodeController = TextEditingController(text: barang?.kode ?? '');
    final namaController = TextEditingController(text: barang?.nama ?? '');
    final stokController = TextEditingController(
      text: barang != null ? barang.stok.toString() : '',
    );
    final hargaController = TextEditingController(
      text: barang != null ? barang.harga.toStringAsFixed(0) : '',
    );

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Row(
            children: [
              Icon(
                isEdit ? Icons.edit_note : Icons.add_shopping_cart,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEdit ? 'Edit Barang' : 'Tambah Barang',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actionsOverflowButtonSpacing: 8,
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: kodeController,
                    decoration: const InputDecoration(
                      labelText: 'Kode Barang*',
                      hintText: 'Contoh: BRG006',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.qr_code),
                    ),
                    textCapitalization: TextCapitalization.characters,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Kode barang wajib diisi';
                      }
                      final trimmed = val.trim().toUpperCase();
                      if (widget.repository.existsKode(
                        trimmed,
                        excludeKode: oldKode,
                      )) {
                        return 'Kode sudah digunakan barang lain';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Barang*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.inventory_2_outlined),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nama barang wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: stokController,
                    decoration: const InputDecoration(
                      labelText: 'Stok Unit*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.numbers),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Stok unit wajib diisi';
                      }
                      final parsed = int.tryParse(val.trim());
                      if (parsed == null || parsed < 0) {
                        return 'Stok harus ≥ 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: hargaController,
                    decoration: const InputDecoration(
                      labelText: 'Harga Satuan (Rp)*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.payments_outlined),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Harga satuan wajib diisi';
                      }
                      final parsed = double.tryParse(val.trim());
                      if (parsed == null || parsed < 0) {
                        return 'Harga harus ≥ 0';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Batal'),
            ),
            FilledButton.icon(
              icon: Icon(isEdit ? Icons.save : Icons.add),
              label: Text(isEdit ? 'Perbarui' : 'Simpan'),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final kode = kodeController.text.trim().toUpperCase();
                  final nama = namaController.text.trim();
                  final stok = int.parse(stokController.text.trim());
                  final harga = double.parse(hargaController.text.trim());

                  setState(() {
                    if (isEdit) {
                      widget.repository.update(
                        barang.copyWith(
                          kode: kode,
                          nama: nama,
                          stok: stok,
                          harga: harga,
                        ),
                        oldKode: oldKode,
                      );
                    } else {
                      widget.repository.add(
                        Barang(
                          kode: kode,
                          nama: nama,
                          stok: stok,
                          harga: harga,
                        ),
                      );
                    }
                  });

                  Navigator.pop(dialogCtx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEdit ? 'Data barang $nama berhasil diperbarui' : 'Barang baru $nama berhasil ditambahkan',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listBarang = _dataTampil;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Responsif
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Inventory Barang',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: _tambahData,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Tambah'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Stat Cards Perhitungan Bagian K Responsif
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Jenis Barang',
                    value: '$_totalJenisBarang Item',
                    subtitle: '$_totalUnitStok unit',
                    icon: Icons.inventory_outlined,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatCard(
                    title: 'Total Persediaan',
                    value: formatRupiah(_totalPersediaanSemua),
                    subtitle: 'Σ(stok × harga)',
                    icon: Icons.account_balance_wallet_outlined,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Barang',
                hintText: 'Nama atau kode barang...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _keyword.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _keyword = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                isDense: true,
              ),
              onChanged: (val) {
                setState(() => _keyword = val);
              },
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menampilkan ${listBarang.length} dari $_totalJenisBarang barang',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                if (_keyword.isNotEmpty)
                  Text(
                    'Subtotal: ${formatRupiah(_totalPersediaanTampil)}',
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),

            // ================================================================
            // TAMPILAN DATA MENGGUNAKAN ListView.builder (LKM Bagian K & Q)
            // ================================================================
            Expanded(
              child: listBarang.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove_shopping_cart, size: 54, color: Colors.grey.shade400),
                          const SizedBox(height: 6),
                          Text(
                            'Barang tidak ditemukan',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: listBarang.length,
                      itemBuilder: (context, index) {
                        final b = listBarang[index];
                        final nilaiBarang = b.nilaiTotal; // stok * harga

                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 0.8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.deepOrange.shade50,
                                  foregroundColor: Colors.deepOrange.shade800,
                                  child: const Icon(Icons.devices_other, size: 20),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        b.nama,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Kode: ${b.kode} • Stok: ${b.stok} unit',
                                        style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                                      ),
                                      Text(
                                        'Harga: ${formatRupiah(b.harga)}',
                                        style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade50,
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: Colors.green.shade200),
                                        ),
                                        child: Text(
                                          'Nilai: ${formatRupiah(nilaiBarang)} (${b.stok} × ${formatRupiah(b.harga)})',
                                          style: TextStyle(
                                            color: Colors.green.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      tooltip: 'Edit Barang',
                                      icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 20),
                                      onPressed: () => _editData(b),
                                    ),
                                    IconButton(
                                      tooltip: 'Hapus Barang',
                                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                      onPressed: () => _hapusData(b),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
