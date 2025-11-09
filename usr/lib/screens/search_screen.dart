import 'package:flutter/material.dart';
import '../models/diwan.dart';
import '../models/poem.dart';
import '../services/mock_data_service.dart';
import '../widgets/diwan_card.dart';
import '../widgets/poem_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Diwan> diwanResults = [];
  List<Poem> poemResults = [];
  bool isSearching = false;
  String searchType = 'all'; // 'all', 'diwans', 'poems'

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        diwanResults = [];
        poemResults = [];
        isSearching = false;
      });
      return;
    }

    setState(() => isSearching = true);

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      
      setState(() {
        if (searchType == 'all' || searchType == 'diwans') {
          diwanResults = MockDataService.searchDiwans(query);
        } else {
          diwanResults = [];
        }
        
        if (searchType == 'all' || searchType == 'poems') {
          poemResults = MockDataService.searchPoems(query);
        } else {
          poemResults = [];
        }
        
        isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasResults = diwanResults.isNotEmpty || poemResults.isNotEmpty;
    final showEmptyState = _searchController.text.isNotEmpty && !hasResults && !isSearching;

    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث'),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.amber.shade50,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن ديوان، شاعر، أو قصيدة...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _performSearch('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber.shade700),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: _performSearch,
                ),
                const SizedBox(height: 12),
                // Search Type Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSearchTypeChip('الكل', 'all'),
                    const SizedBox(width: 8),
                    _buildSearchTypeChip('دواوين', 'diwans'),
                    const SizedBox(width: 8),
                    _buildSearchTypeChip('قصائد', 'poems'),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Results
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : showEmptyState
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'لا توجد نتائج',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : _searchController.text.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 80,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'ابدأ البحث عن دواوين أو قصائد',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (diwanResults.isNotEmpty) ..[
                                  Text(
                                    'الدواوين (${diwanResults.length})',
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: 12),
                                  ...diwanResults.map((diwan) => DiwanCard(
                                        diwan: diwan,
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/diwan-details',
                                            arguments: diwan,
                                          );
                                        },
                                      )),
                                  const SizedBox(height: 24),
                                ],
                                if (poemResults.isNotEmpty) ..[
                                  Text(
                                    'القصائد (${poemResults.length})',
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: 12),
                                  ...poemResults.map((poem) => PoemCard(
                                        poem: poem,
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/poem-viewer',
                                            arguments: poem,
                                          );
                                        },
                                      )),
                                ],
                              ],
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTypeChip(String label, String value) {
    final isSelected = searchType == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          searchType = value;
          _performSearch(_searchController.text);
        });
      },
      backgroundColor: Colors.white,
      selectedColor: Colors.amber,
      checkmarkColor: Colors.brown,
      labelStyle: TextStyle(
        color: isSelected ? Colors.brown : Colors.grey.shade700,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}