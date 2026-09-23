import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../repositories/mahasiswa_repository.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/stat_card.dart';

class MahasiswaPage extends StatefulWidget {
  final MahasiswaRepository repository;

  const MahasiswaPage({super.key, required this.repository});

  @override
  State<MahasiswaPage> createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  String _keyword = '';
  String _filterIpk = 'Semua';
  String _sortBy = 'Nama A-Z';
  final TextEditingController _searchController = TextEditingController();

  List<Mahasiswa> get _dataTampil {
    return widget.repository.getFilteredAndSorted(
      keyword: _keyword,
      filterIpk: _filterIpk,
      sortBy: _sortBy,
    );
  }

  // Perhitungan Dashboard (Bagian O - Mini Project)
  int get _totalMahasiswa => widget.repository.getAll().length;

  double get _rataRataIpk {
    final all = widget.repository.getAll();
    if (all.isEmpty) return 0.0;
    final totalIpk = all.map((m) => m.ipk).reduce((a, b) => a + b);
    return totalIpk / all.length;
  }

  int get _jumlahCumlaude {
    return widget.repository.getAll().where((m) => m.ipk >= 3.50).length;
  }

  void _tambahData() {
    _showFormMahasiswaDialog();
  }

  void _editData(Mahasiswa mahasiswa) {
    _showFormMahasiswaDialog(mahasiswa: mahasiswa);
  }

  Future<void> _hapusData(Mahasiswa mahasiswa) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: 'Hapus Mahasiswa',
      message: 'Apakah Anda yakin ingin menghapus data "${mahasiswa.nama}" (NIM: ${mahasiswa.nim})?',
    );

    if (confirmed == true && mounted) {
      setState(() {
        widget.repository.delete(mahasiswa);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${mahasiswa.nama} berhasil dihapus'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showFormMahasiswaDialog({Mahasiswa? mahasiswa}) {
    final isEdit = mahasiswa != null;
    final String? oldNim = mahasiswa?.nim; // Menyimpan NIM lama untuk lookup saat edit
    final formKey = GlobalKey<FormState>();

    final nimController = TextEditingController(text: mahasiswa?.nim ?? '');
    final namaController = TextEditingController(text: mahasiswa?.nama ?? '');
    final prodiController = TextEditingController(text: mahasiswa?.prodi ?? '');
    final semesterController = TextEditingController(
      text: mahasiswa != null ? mahasiswa.semester.toString() : '',
    );
    final ipkController = TextEditingController(
      text: mahasiswa != null ? mahasiswa.ipk.toString() : '',
    );

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Row(
            children: [
              Icon(
                isEdit ? Icons.edit_note : Icons.person_add,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa',
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
                  // Field NIM
                  TextFormField(
                    key: const Key('input_nim'),
                    controller: nimController,
                    decoration: const InputDecoration(
                      labelText: 'NIM (Nomor Induk Mahasiswa)*',
                      hintText: 'Contoh: 23010007',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'NIM wajib diisi';
                      }
                      final trimmed = val.trim();
                      if (trimmed.length < 5) {
                        return 'NIM minimal 5 karakter';
                      }
                      // Validasi keunikan NIM (kecuali NIM milik record ini sendiri saat edit)
                      if (widget.repository.existsNim(
                        trimmed,
                        excludeNim: oldNim,
                      )) {
                        return 'NIM sudah terdaftar';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Field Nama
                  TextFormField(
                    key: const Key('input_nama'),
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nama lengkap wajib diisi';
                      }
                      if (val.trim().length < 2) {
                        return 'Nama minimal 2 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Field Program Studi
                  TextFormField(
                    key: const Key('input_prodi'),
                    controller: prodiController,
                    decoration: const InputDecoration(
                      labelText: 'Program Studi*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.school_outlined),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Program studi wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Field Semester
                  TextFormField(
                    key: const Key('input_semester'),
                    controller: semesterController,
                    decoration: const InputDecoration(
                      labelText: 'Semester (1 - 14)*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Semester wajib diisi';
                      }
                      final numVal = int.tryParse(val.trim());
                      if (numVal == null || numVal < 1 || numVal > 14) {
                        return 'Semester antara 1 - 14';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Field IPK
                  TextFormField(
                    key: const Key('input_ipk'),
                    controller: ipkController,
                    decoration: const InputDecoration(
                      labelText: 'IPK (0.00 - 4.00)*',
                      hintText: 'Contoh: 3.75',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.grade_outlined),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'IPK wajib diisi';
                      }
                      final parsed = double.tryParse(val.trim().replaceAll(',', '.'));
                      if (parsed == null || parsed < 0.0 || parsed > 4.00) {
                        return 'IPK antara 0.00 - 4.00';
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
              key: const Key('btn_simpan_mahasiswa'),
              icon: Icon(isEdit ? Icons.save : Icons.add),
              label: Text(isEdit ? 'Perbarui' : 'Simpan'),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final nim = nimController.text.trim();
                  final nama = namaController.text.trim();
                  final prodi = prodiController.text.trim();
                  final semester = int.parse(semesterController.text.trim());
                  final ipk = double.parse(ipkController.text.trim().replaceAll(',', '.'));

                  setState(() {
                    if (isEdit) {
                      widget.repository.update(
                        mahasiswa.copyWith(
                          nim: nim,
                          nama: nama,
                          prodi: prodi,
                          semester: semester,
                          ipk: ipk,
                        ),
                        oldNim: oldNim, // Menggunakan oldNim agar perubahan NIM ter-update sempurna
                      );
                    } else {
                      widget.repository.add(
                        Mahasiswa(
                          nim: nim,
                          nama: nama,
                          prodi: prodi,
                          semester: semester,
                          ipk: ipk,
                        ),
                      );
                    }
                  });

                  Navigator.pop(dialogCtx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEdit ? 'Data $nama berhasil diperbarui' : 'Mahasiswa baru berhasil disimpan',
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
    final listMahasiswa = _dataTampil;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section Responsif (Bebas Overflow pada 390px)
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Data Mahasiswa',
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
                  key: const Key('btn_tambah_mahasiswa'),
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

            // Dashboard Stat Cards Responsif (Scroll Horizontal pada Ponsel Sempit)
            LayoutBuilder(
              builder: (context, constraints) {
                final card1 = StatCard(
                  title: 'Total Mahasiswa',
                  value: '$_totalMahasiswa Mhs',
                  subtitle: 'Koleksi aktif',
                  icon: Icons.people_alt_outlined,
                  color: Colors.indigo,
                );
                final card2 = StatCard(
                  title: 'Rata-rata IPK',
                  value: _rataRataIpk.toStringAsFixed(2),
                  subtitle: 'Skala 4.00',
                  icon: Icons.analytics_outlined,
                  color: Colors.teal,
                );
                final card3 = StatCard(
                  title: 'IPK ≥ 3.50',
                  value: '$_jumlahCumlaude Mhs',
                  subtitle: 'Berprestasi',
                  icon: Icons.workspace_premium_outlined,
                  color: Colors.amber.shade800,
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

            // Search Bar (NIM, Nama, Prodi, Semester)
            TextField(
              key: const Key('input_search_mahasiswa'),
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Mahasiswa',
                hintText: 'NIM, nama, prodi, atau semester...',
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

            // Filter & Sorting Control Responsif
            LayoutBuilder(
              builder: (context, constraints) {
                final filterChips = Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    ChoiceChip(
                      label: const Text('Semua', style: TextStyle(fontSize: 12)),
                      selected: _filterIpk == 'Semua',
                      onSelected: (_) => setState(() => _filterIpk = 'Semua'),
                      visualDensity: VisualDensity.compact,
                    ),
                    ChoiceChip(
                      label: const Text('IPK ≥ 3.50', style: TextStyle(fontSize: 12)),
                      selected: _filterIpk == 'IPK ≥ 3.50',
                      onSelected: (_) => setState(() => _filterIpk = 'IPK ≥ 3.50'),
                      visualDensity: VisualDensity.compact,
                    ),
                    ChoiceChip(
                      label: const Text('IPK < 3.50', style: TextStyle(fontSize: 12)),
                      selected: _filterIpk == 'IPK < 3.50',
                      onSelected: (_) => setState(() => _filterIpk = 'IPK < 3.50'),
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
                        DropdownMenuItem(value: 'Nama Z-A', child: Text('Nama Z-A')),
                        DropdownMenuItem(value: 'IPK Tertinggi', child: Text('IPK Tertinggi')),
                        DropdownMenuItem(value: 'IPK Terendah', child: Text('IPK Terendah')),
                        DropdownMenuItem(value: 'Semester', child: Text('Semester')),
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

            // Info Jumlah Data Tampil
            Text(
              'Menampilkan ${listMahasiswa.length} dari $_totalMahasiswa mahasiswa',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),

            // ================================================================
            // TAMPILAN DATA MENGGUNAKAN ListView.builder (LKM Bagian F & Q)
            // ================================================================
            Expanded(
              child: listMahasiswa.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 54, color: Colors.grey.shade400),
                          const SizedBox(height: 6),
                          Text(
                            'Data mahasiswa tidak ditemukan',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: listMahasiswa.length,
                      itemBuilder: (context, index) {
                        final mahasiswa = listMahasiswa[index];
                        final isHighIpk = mahasiswa.ipk >= 3.50;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 0.8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isHighIpk ? Colors.amber.shade200 : Colors.grey.shade200,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: isHighIpk
                                  ? Colors.amber.shade100
                                  : Colors.indigo.shade50,
                              foregroundColor: isHighIpk
                                  ? Colors.amber.shade900
                                  : Colors.indigo.shade800,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    mahasiswa.nama,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isHighIpk)
                                  Tooltip(
                                    message: 'Mahasiswa Berprestasi (IPK ≥ 3.50)',
                                    child: Icon(Icons.star, color: Colors.amber.shade700, size: 16),
                                  ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${mahasiswa.nim} • ${mahasiswa.prodi}',
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Wrap(
                                    spacing: 4,
                                    children: [
                                      Chip(
                                        label: Text('Sem ${mahasiswa.semester}'),
                                        labelStyle: const TextStyle(fontSize: 10),
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      Chip(
                                        label: Text('IPK ${mahasiswa.ipk.toStringAsFixed(2)}'),
                                        labelStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: isHighIpk
                                              ? Colors.amber.shade900
                                              : Colors.teal.shade900,
                                        ),
                                        backgroundColor: isHighIpk
                                            ? Colors.amber.shade50
                                            : Colors.teal.shade50,
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    ],
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
                                  onPressed: () => _editData(mahasiswa),
                                ),
                                IconButton(
                                  tooltip: 'Hapus Data',
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                  onPressed: () => _hapusData(mahasiswa),
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
