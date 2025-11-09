import 'package:flutter/material.dart';
import '../models/poem.dart';

class PoemCard extends StatelessWidget {
  final Poem poem;
  final VoidCallback onTap;

  const PoemCard({
    super.key,
    required this.poem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Poem Type Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: poem.type == PoemType.video
                      ? Colors.red.shade50
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  poem.type == PoemType.video
                      ? Icons.play_circle_outline
                      : Icons.picture_as_pdf,
                  size: 28,
                  color: poem.type == PoemType.video
                      ? Colors.red.shade700
                      : Colors.blue.shade700,
                ),
              ),
              const SizedBox(width: 16),
              // Poem Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      poem.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (poem.description != null) ..[
                      const SizedBox(height: 4),
                      Text(
                        poem.description!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${poem.views}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.favorite,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${poem.likes}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Type Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: poem.type == PoemType.video
                      ? Colors.red.shade100
                      : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  poem.type == PoemType.video ? 'فيديو' : 'PDF',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: poem.type == PoemType.video
                        ? Colors.red.shade800
                        : Colors.blue.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}