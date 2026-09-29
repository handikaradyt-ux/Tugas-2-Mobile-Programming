import 'package:flutter/material.dart';
import '../repositories/mahasiswa_repository.dart';
import '../repositories/mata_kuliah_repository.dart';
import '../repositories/barang_repository.dart';
import 'mahasiswa_page.dart';
import 'mata_kuliah_page.dart';
import 'inventory_page.dart';
import 'collection_exploration_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Inisialisasi Repository In-Memory (Satu instance selama siklus hidup aplikasi)
  late final MahasiswaRepository _mahasiswaRepo;
  late final MataKuliahRepository _mataKuliahRepo;
  late final BarangRepository _barangRepo;

  @override
  void initState() {
    super.initState();
    _mahasiswaRepo = InMemoryMahasiswaRepository();
    _mataKuliahRepo = InMemoryMataKuliahRepository();
    _barangRepo = InMemoryBarangRepository();

    final tabParam = Uri.base.queryParameters['tab'];
    if (tabParam != null) {
      final tabIdx = int.tryParse(tabParam);
      if (tabIdx != null && tabIdx >= 0 && tabIdx <= 3) {
        _currentIndex = tabIdx;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MahasiswaPage(repository: _mahasiswaRepo),
      MataKuliahPage(repository: _mataKuliahRepo),
      InventoryPage(repository: _barangRepo),
      const CollectionExplorationPage(),
    ];

    final isWideScreen = MediaQuery.of(context).size.width >= 700;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.collections_bookmark_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'LKM Koleksi Flutter',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          if (MediaQuery.of(context).size.width >= 600)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Chip(
                avatar: Icon(Icons.school, size: 16),
                label: Text('Mobile Programming'),
                visualDensity: VisualDensity.compact,
              ),
            ),
        ],
      ),
      body: isWideScreen
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() => _currentIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Icon(Icons.dashboard_customize_outlined),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.people_outline),
                      selectedIcon: Icon(Icons.people),
                      label: Text('Mahasiswa'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: Text('Mata Kuliah'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.inventory_2_outlined),
                      selectedIcon: Icon(Icons.inventory_2),
                      label: Text('Inventory'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.calculate_outlined),
                      selectedIcon: Icon(Icons.calculate),
                      label: Text('Eksplorasi'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: pages,
                  ),
                ),
              ],
            )
          : IndexedStack(
              index: _currentIndex,
              children: pages,
            ),
      bottomNavigationBar: isWideScreen
          ? null
          : NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: 'Mahasiswa',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book),
                  label: 'Mata Kuliah',
                ),
                NavigationDestination(
                  icon: Icon(Icons.inventory_2_outlined),
                  selectedIcon: Icon(Icons.inventory_2),
                  label: 'Inventory',
                ),
                NavigationDestination(
                  icon: Icon(Icons.calculate_outlined),
                  selectedIcon: Icon(Icons.calculate),
                  label: 'Eksplorasi',
                ),
              ],
            ),
    );
  }
}
