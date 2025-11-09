import 'package:flutter/material.dart';
import '../models/poem.dart';

class PoemViewerScreen extends StatefulWidget {
  const PoemViewerScreen({super.key});

  @override
  State<PoemViewerScreen> createState() => _PoemViewerScreenState();
}

class _PoemViewerScreenState extends State<PoemViewerScreen> {
  bool isLiked = false;
  int localLikes = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final poem = ModalRoute.of(context)!.settings.arguments as Poem;
    localLikes = poem.likes;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      localLikes += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final poem = ModalRoute.of(context)!.settings.arguments as Poem;

    return Scaffold(
      appBar: AppBar(
        title: Text(poem.title),
        actions: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : null,
            ),
            onPressed: _toggleLike,
          ),
        ],
      ),
      body: Column(
        children: [
          // Poem Info Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.amber.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  poem.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                if (poem.description != null) ..[
                  const SizedBox(height: 8),
                  Text(
                    poem.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.visibility, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '${poem.views} مشاهدة',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.favorite, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '$localLikes إعجاب',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Content Viewer
          Expanded(
            child: poem.type == PoemType.video
                ? _buildVideoViewer(poem)
                : _buildPdfViewer(poem),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoViewer(Poem poem) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_circle_outline,
            size: 120,
            color: Colors.amber.shade700,
          ),
          const SizedBox(height: 24),
          Text(
            'مشغل الفيديو',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'ملاحظة: سيتم تشغيل الفيديو عند الاتصال بالإنترنت',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement video player
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('سيتم تشغيل الفيديو هنا'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('تشغيل'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.brown,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfViewer(Poem poem) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.picture_as_pdf,
            size: 120,
            color: Colors.red.shade700,
          ),
          const SizedBox(height: 24),
          Text(
            'عارض PDF',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'ملاحظة: سيتم فتح ملف PDF للقراءة',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement PDF viewer
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('سيتم فتح ملف PDF هنا'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.open_in_new),
            label: const Text('فتح'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}