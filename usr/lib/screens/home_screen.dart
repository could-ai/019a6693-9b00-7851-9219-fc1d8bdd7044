import 'package:flutter/material.dart';
import '../models/diwan.dart';
import '../services/mock_data_service.dart';
import '../widgets/diwan_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Diwan> diwans = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDiwans();
  }

  Future<void> _loadDiwans() async {
    setState(() => isLoading = true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      diwans = MockDataService.getMockDiwans();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'منصة الشعر والشعراء',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () {
              Navigator.pushNamed(context, '/poet-dashboard');
            },
            tooltip: 'لوحة تحكم الشاعر',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadDiwans,
              child: diwans.isEmpty
                  ? const Center(
                      child: Text(
                        'لا توجد دواوين متاحة حالياً',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: diwans.length,
                      itemBuilder: (context, index) {
                        final diwan = diwans[index];
                        return DiwanCard(
                          diwan: diwan,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/diwan-details',
                              arguments: diwan,
                            );
                          },
                        );
                      },
                    ),
            ),
    );
  }
}