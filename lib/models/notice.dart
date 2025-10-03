enum Category { exam, event, academic, general }

enum Priority { low, medium, high }

class Notice {
  String id;
  String title;
  String description;
  Category category;
  Priority priority;
  DateTime createdAt;
  DateTime? updatedAt;
  String? filePath;
  String authorId;
  String authorName;
  bool isFavorite;

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.priority = Priority.medium,
    DateTime? createdAt,
    this.updatedAt,
    this.filePath,
    required this.authorId,
    required this.authorName,
    this.isFavorite = false,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category.name,
      'priority': priority.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'filePath': filePath,
      'authorId': authorId,
      'authorName': authorName,
      'isFavorite': isFavorite,
    };
  }

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: Category.values.firstWhere((e) => e.name == json['category']),
      priority: Priority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => Priority.medium,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      filePath: json['filePath'],
      authorId: json['authorId'] ?? 'unknown',
      authorName: json['authorName'] ?? 'Unknown Author',
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
