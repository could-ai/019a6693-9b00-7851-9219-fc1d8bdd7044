class Poet {
  final String id;
  final String name;
  final String bio;
  final String? profileImage;
  final DateTime joinedDate;
  final bool isVerified;

  Poet({
    required this.id,
    required this.name,
    required this.bio,
    this.profileImage,
    required this.joinedDate,
    this.isVerified = false,
  });

  factory Poet.fromJson(Map<String, dynamic> json) {
    return Poet(
      id: json['id'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String,
      profileImage: json['profile_image'] as String?,
      joinedDate: DateTime.parse(json['joined_date'] as String),
      isVerified: json['is_verified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profile_image': profileImage,
      'joined_date': joinedDate.toIso8601String(),
      'is_verified': isVerified,
    };
  }
}