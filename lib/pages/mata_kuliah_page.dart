import 'package:flutter/material.dart';
import '../models/mata_kuliah.dart';
import '../repositories/mata_kuliah_repository.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/stat_card.dart';

class MataKuliahPage extends StatefulWidget {
  final MataKuliahRepository repository;

  const MataKuliahPage({super.key, required this.repository});

  @override
  State<MataKuliahPage> createState() => _MataKuliahPageState();
}

class _MataKuliahPageState extends State<MataKuliahPage> {
  String _keyword = '';
  String _filterSks = 'Semua';
  String _sortBy = 'Nama A-Z';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final q = Uri.base.queryParameters;
    if (q['mk_search'] != null) {
      _keyword = q['mk_search']!;
      _searchController.text = _keyword;
    }
    if (q['mk_filter'] != null) {
      _filterSks = q['mk_filter']!;
    }
    if (q['mk_sort'] != null) {
      _sortBy = q['mk_sort']!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (q['mk_action'] == 'tambah') {
        _tambahData();
      } else if (q['mk_action'] == 'edit') {
        final list = widget.repository.getAll();
        if (list.isNotEmpty) _editData(list.first);
      } else if (q['mk_action'] == 'delete') {
        final list = widget.repository.getAll();
        if (list.isNotEmpty) _hapusData(list.first);
      }
    });
  }

  List<MataKuliah> get _dataTampil {
    return widget.repository.getFilteredAndSorted(
      keyword: _keyword,
      filterSks: _filterSks,
      sortBy: _sortBy,
    );
  }

  // Ringkasan Dinamis (Challenge Bagian J)
  int get _jumlahMkTampil => _dataTampil.length;

  int get _totalSksTampil {
    if (_dataTampil.isEmpty) return 0;
    return _dataTampil.map((mk) => mk.sks).reduce((a, b) => a + b);
  }

  double get _rataRataSksTampil {
    if (_dataTampil.isEmpty) return 0.0;
    return _totalSksTampil / _dataTampil.length;
  }

  void _tambahData() {
    _showFormDialog();
  }

  void _editData(MataKuliah mk) {
    _showFormDialog(mataKuliah: mk);
  }

  Future<void> _hapusData(MataKuliah mk) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: 'Hapus Mata Kuliah',
      message: 'Apakah Anda yakin ingin menghapus "${mk.nama}" (${mk.kode})?',
    );

    if (confirmed == true && mounted) {
      setState(() {
        widget.repository.delete(mk);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${mk.nama} berhasil dihapus'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showFormDialog({MataKuliah? mataKuliah}) {
    final isEdit = mataKuliah != null;
    final String? oldKode = mataKuliah?.kode;
    final formKey = GlobalKey<FormState>();

    final kodeController = TextEditingController(text: mataKuliah?.kode ?? '');
    final namaController = TextEditingController(text: mataKuliah?.nama ?? '');
    final sksController = TextEditingController(
      text: mataKuliah != null ? mataKuliah.sks.toString() : '3',
    );
    final dosenController = TextEditingController(text: mataKuliah?.dosen ?? '');

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Row(
            children: [
              Icon(
                isEdit ? Icons.edit_note : Icons.add_box_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEdit ? 'Edit Mata Kuliah' : 'Tambah Mata Kuliah',
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
                      labelText: 'Kode Mata Kuliah*',
                      hintText: 'Contoh: IF2107',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.code),
                    ),
                    textCapitalization: TextCapitalization.characters,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Kode mata kuliah wajib diisi';
                      }
                      final trimmed = val.trim().toUpperCase();
                      if (widget.repository.existsKode(
                        trimmed,
                        excludeKode: oldKode,
                      )) {
                        return 'Kode sudah digunakan mata kuliah lain';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Mata Kuliah*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.book_outlined),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nama mata kuliah wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: sksController,
                    decoration: const InputDecoration(
                      labelText: 'Bobot SKS (1-6)*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.access_time),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'SKS wajib diisi';
                      }
                      final parsed = int.tryParse(val.trim());
                      if (parsed == null || parsed < 1 || parsed > 6) {
                        return 'SKS harus antara 1 sampai 6';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: dosenController,
                    decoration: const InputDecoration(
                      labelText: 'Dosen Pengampu*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_pin_outlined),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Dosen pengampu wajib diisi';
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
                  final sks = int.parse(sksController.text.trim());
                  final dosen = dosenController.text.trim();

                  setState(() {
                    if (isEdit) {
                      widget.repository.update(
                        mataKuliah.copyWith(
                          kode: kode,
                          nama: nama,
                          sks: sks,
                          dosen: dosen,
                        ),
                        oldKode: oldKode,
                      );
                    } else {
                      widget.repository.add(
                        MataKuliah(
                          kode: kode,
                          nama: nama,
                          sks: sks,
                          dosen: dosen,
                        ),
                      );
                    }
                  });

                  Navigator.pop(dialogCtx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEdit ? 'Mata kuliah $nama berhasil diperbarui' : 'Mata kuliah $nama berhasil ditambahkan',
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
    final listMk = _dataTampil;

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
                    'Data Mata Kuliah',
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

            // Ringkasan Dinamis (Challenge Bagian J) Responsif
            LayoutBuilder(
              builder: (context, constraints) {
                final card1 = StatCard(
                  title: 'MK Tampil',
                  value: '$_jumlahMkTampil MK',
                  subtitle: 'Filter aktif',
                  icon: Icons.menu_book_outlined,
                  color: Colors.deepPurple,
                );
                final card2 = StatCard(
                  title: 'Total SKS',
                  value: '$_totalSksTampil SKS',
                  subtitle: 'Σ(SKS)',
                  icon: Icons.functions_outlined,
                  color: Colors.blueAccent,
                );
                final card3 = StatCard(
                  title: 'Rata-rata SKS',
                  value: _rataRataSksTampil.toStringAsFixed(2),
                  subtitle: 'SKS / MK',
                  icon: Icons.trending_up,
                  color: Colors.teal,
                );

                if (constraints.maxWidth >= 550) {
                  return Row(
                    children: [
                      Expanded(child: card1),
                      const SizedBox(width: 8),
                      Expanded(child: card2),
                      const SizedBox(width: 8),
                      Expanded(child: card3),
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 135, child: card1),
                        const SizedBox(width: 8),
                        SizedBox(width: 135, child: card2),
                        const SizedBox(width: 8),
                        SizedBox(width: 135, child: card3),
                      ],
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),

            // Search Bar (Kode, Nama, Dosen)
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Mata Kuliah',
                hintText: 'Kode, nama, atau dosen pengampu...',
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

            // Filter SKS Challenge & Sorting SKS (Urutan Naik)
            LayoutBuilder(
              builder: (context, constraints) {
                final filterChips = Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    ChoiceChip(
                      label: const Text('Semua', style: TextStyle(fontSize: 12)),
                      selected: _filterSks == 'Semua',
                      onSelected: (_) => setState(() => _filterSks = 'Semua'),
                      visualDensity: VisualDensity.compact,
                    ),
                    ChoiceChip(
                      label: const Text('2 SKS', style: TextStyle(fontSize: 12)),
                      selected: _filterSks == '2 SKS',
                      onSelected: (_) => setState(() => _filterSks = '2 SKS'),
                      visualDensity: VisualDensity.compact,
                    ),
                    ChoiceChip(
                      label: const Text('3 SKS', style: TextStyle(fontSize: 12)),
                      selected: _filterSks == '3 SKS',
                      onSelected: (_) => setState(() => _filterSks = '3 SKS'),
                      visualDensity: VisualDensity.compact,
                    ),
                    ChoiceChip(
                      label: const Text('4 SKS', style: TextStyle(fontSize: 12)),
                      selected: _filterSks == '4 SKS',
                      onSelected: (_) => setState(() => _filterSks = '4 SKS'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                );

                final sortDropdown = Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _sortBy,
                      isDense: true,
                      icon: const Icon(Icons.sort, size: 16),
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade900),
                      items: const [
                        DropdownMenuItem(value: 'Nama A-Z', child: Text('Nama A-Z')),
                        DropdownMenuItem(
                          value: 'SKS (Urutan Naik)',
                          child: Text('SKS (Urutan Naik)'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _sortBy = val);
                      },
                    ),
                  ),
                );

                if (constraints.maxWidth >= 500) {
                  return Row(
                    children: [
                      Expanded(child: filterChips),
                      const SizedBox(width: 8),
                      sortDropdown,
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: filterChips),
                      sortDropdown,
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 6),

            // Info Teks Ringkas
            Text(
              'Menampilkan ${listMk.length} mata kuliah (Ringkasan dinamis)',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            // ================================================================
            // TAMPILAN DATA MENGGUNAKAN ListView.builder (LKM Bagian J & Q)
            // ================================================================
            Expanded(
              child: listMk.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 54, color: Colors.grey.shade400),
                          const SizedBox(height: 6),
                          Text(
                            'Mata kuliah tidak ditemukan',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: listMk.length,
                      itemBuilder: (context, index) {
                        final mk = listMk[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 0.8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            leading: Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${mk.sks}\nSKS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.deepPurple.shade700,
                                ),
                              ),
                            ),
                            title: Text(
                              mk.nama,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kode: ${mk.kode}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Dosen: ${mk.dosen}',
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 11),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Edit Data',
                                  icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 20),
                                  onPressed: () => _editData(mk),
                                ),
                                IconButton(
                                  tooltip: 'Hapus Data',
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                  onPressed: () => _hapusData(mk),
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
