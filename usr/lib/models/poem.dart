enum PoemType {
  video,
  pdf,
}

class Poem {
  final String id;
  final String diwanId;
  final String poetId;
  final String title;
  final String? description;
  final PoemType type;
  final String contentUrl; // URL for video or PDF
  final String? thumbnailUrl;
  final DateTime createdAt;
  final bool isApproved;
  final int views;
  final int likes;

  Poem({
    required this.id,
    required this.diwanId,
    required this.poetId,
    required this.title,
    this.description,
    required this.type,
    required this.contentUrl,
    this.thumbnailUrl,
    required this.createdAt,
    this.isApproved = false,
    this.views = 0,
    this.likes = 0,
  });

  factory Poem.fromJson(Map<String, dynamic> json) {
    return Poem(
      id: json['id'] as String,
      diwanId: json['diwan_id'] as String,
      poetId: json['poet_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: json['type'] == 'video' ? PoemType.video : PoemType.pdf,
      contentUrl: json['content_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      isApproved: json['is_approved'] as bool? ?? false,
      views: json['views'] as int? ?? 0,
      likes: json['likes'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'diwan_id': diwanId,
      'poet_id': poetId,
      'title': title,
      'description': description,
      'type': type == PoemType.video ? 'video' : 'pdf',
      'content_url': contentUrl,
      'thumbnail_url': thumbnailUrl,
      'created_at': createdAt.toIso8601String(),
      'is_approved': isApproved,
      'views': views,
      'likes': likes,
    };
  }
}