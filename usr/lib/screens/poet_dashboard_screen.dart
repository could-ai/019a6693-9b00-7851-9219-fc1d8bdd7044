import 'package:flutter/material.dart';
import '../models/diwan.dart';
import '../models/poem.dart';
import '../services/mock_data_service.dart';

class PoetDashboardScreen extends StatefulWidget {
  const PoetDashboardScreen({super.key});

  @override
  State<PoetDashboardScreen> createState() => _PoetDashboardScreenState();
}

class _PoetDashboardScreenState extends State<PoetDashboardScreen> {
  int _selectedIndex = 0;
  final String currentPoetId = '1'; // Mock current poet
  List<Diwan> myDiwans = [];
  List<Poem> pendingPoems = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Load poet's diwans
    myDiwans = MockDataService.getMockDiwans()
        .where((d) => d.poetId == currentPoetId)
        .toList();

    // Mock pending poems awaiting approval
    pendingPoems = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الشاعر'),
      ),
      body: _selectedIndex == 0 ? _buildMyDiwansTab() : _buildAddPoemTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber.shade700,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'دواويني',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'إضافة قصيدة',
          ),
        ],
      ),
    );
  }

  Widget _buildMyDiwansTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Create New Diwan Button
        Card(
          color: Colors.amber.shade50,
          child: InkWell(
            onTap: _showCreateDiwanDialog,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle, color: Colors.amber.shade700, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'إنشاء ديوان جديد',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // My Diwans List
        if (myDiwans.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'لم تقم بإنشاء أي دواوين بعد',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ),
          )
        else
          ...myDiwans.map((diwan) => Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  diwan.title,
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  diwan.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: diwan.isApproved
                                  ? Colors.green.shade100
                                  : Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              diwan.isApproved ? 'معتمد' : 'قيد المراجعة',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: diwan.isApproved
                                    ? Colors.green.shade800
                                    : Colors.orange.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'عدد القصائد: ${diwan.poemsCount}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              )),
      ],
    );
  }

  Widget _buildAddPoemTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: Colors.amber.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Icons.info_outline, color: Colors.amber.shade700, size: 48),
                const SizedBox(height: 12),
                const Text(
                  'ملاحظة مهمة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'جميع القصائد المضافة تحتاج إلى موافقة المشرف قبل ظهورها للجمهور',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown.shade700),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildAddPoemForm(),
      ],
    );
  }

  Widget _buildAddPoemForm() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    PoemType selectedType = PoemType.pdf;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'إضافة قصيدة جديدة',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            // Diwan Selection
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'اختر الديوان',
                border: OutlineInputBorder(),
              ),
              items: myDiwans.map((diwan) {
                return DropdownMenuItem(
                  value: diwan.id,
                  child: Text(diwan.title),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            // Poem Title
            TextField(
              controller: titleController,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'عنوان القصيدة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Poem Description
            TextField(
              controller: descriptionController,
              textAlign: TextAlign.right,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'وصف القصيدة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Poem Type
            Text(
              'نوع المحتوى:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<PoemType>(
                    title: const Text('فيديو'),
                    value: PoemType.video,
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() => selectedType = value!);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<PoemType>(
                    title: const Text('PDF'),
                    value: PoemType.pdf,
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() => selectedType = value!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // File Upload Button
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('سيتم فتح نافذة اختيار الملف'),
                  ),
                );
              },
              icon: const Icon(Icons.upload_file),
              label: Text(
                selectedType == PoemType.video
                    ? 'رفع ملف فيديو'
                    : 'رفع ملف PDF',
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 24),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (myDiwans.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('يجب إنشاء ديوان أولاً'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إرسال القصيدة للمراجعة'),
                    backgroundColor: Colors.green,
                  ),
                );
                
                titleController.clear();
                descriptionController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.brown,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'إضافة القصيدة',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateDiwanDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إنشاء ديوان جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                labelText: 'اسم الديوان',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              textAlign: TextAlign.right,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'وصف الديوان',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('يرجى إدخال اسم الديوان'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إنشاء الديوان بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              
              titleController.clear();
              descriptionController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.brown,
            ),
            child: const Text('إنشاء'),
          ),
        ],
      ),
    );
  }
}