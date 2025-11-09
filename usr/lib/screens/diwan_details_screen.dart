import 'package:flutter/material.dart';
import '../models/diwan.dart';
import '../models/poem.dart';
import '../services/mock_data_service.dart';
import '../widgets/poem_card.dart';

class DiwanDetailsScreen extends StatefulWidget {
  const DiwanDetailsScreen({super.key});

  @override
  State<DiwanDetailsScreen> createState() => _DiwanDetailsScreenState();
}

class _DiwanDetailsScreenState extends State<DiwanDetailsScreen> {
  List<Poem> poems = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final diwan = ModalRoute.of(context)!.settings.arguments as Diwan;
    _loadPoems(diwan.id);
  }

  Future<void> _loadPoems(String diwanId) async {
    setState(() => isLoading = true);
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      poems = MockDataService.getMockPoems(diwanId);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final diwan = ModalRoute.of(context)!.settings.arguments as Diwan;

    return Scaffold(
      appBar: AppBar(
        title: Text(diwan.title),
      ),
      body: Column(
        children: [
          // Diwan Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber.shade100, Colors.amber.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.book,
                  size: 64,
                  color: Colors.brown,
                ),
                const SizedBox(height: 12),
                Text(
                  diwan.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'للشاعر: ${diwan.poetName}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.brown.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  diwan.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'عدد القصائد: ${diwan.poemsCount}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.brown,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Poems List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : poems.isEmpty
                    ? const Center(
                        child: Text(
                          'لا توجد قصائد في هذا الديوان',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: poems.length,
                        itemBuilder: (context, index) {
                          final poem = poems[index];
                          return PoemCard(
                            poem: poem,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/poem-viewer',
                                arguments: poem,
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}