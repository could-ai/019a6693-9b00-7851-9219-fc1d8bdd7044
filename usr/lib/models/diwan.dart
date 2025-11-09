class Diwan {
  final String id;
  final String poetId;
  final String poetName;
  final String title;
  final String description;
  final String? coverImage;
  final DateTime createdAt;
  final int poemsCount;
  final bool isApproved;

  Diwan({
    required this.id,
    required this.poetId,
    required this.poetName,
    required this.title,
    required this.description,
    this.coverImage,
    required this.createdAt,
    this.poemsCount = 0,
    this.isApproved = false,
  });

  factory Diwan.fromJson(Map<String, dynamic> json) {
    return Diwan(
      id: json['id'] as String,
      poetId: json['poet_id'] as String,
      poetName: json['poet_name'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      coverImage: json['cover_image'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      poemsCount: json['poems_count'] as int? ?? 0,
      isApproved: json['is_approved'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poet_id': poetId,
      'poet_name': poetName,
      'title': title,
      'description': description,
      'cover_image': coverImage,
      'created_at': createdAt.toIso8601String(),
      'poems_count': poemsCount,
      'is_approved': isApproved,
    };
  }
}