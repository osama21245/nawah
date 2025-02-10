class TeacherModel {
  final String id;
  final String name;
  final String email;
  final String? description;
  final String? image;
  final List<TeachingLevelModel> teachingLevels;

  TeacherModel({
    required this.id,
    required this.name,
    required this.email,
    this.description,
    this.image,
    required this.teachingLevels,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      description: map['description']?.toString(),
      teachingLevels: (map['teaching_levels'] as List?)
              ?.map((level) =>
                  TeachingLevelModel.fromMap(level as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class TeachingLevelModel {
  final String id;
  final String name;
  final String subject;
  final String description;
  final String price;
  final String discount;

  TeachingLevelModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.description,
    required this.price,
    required this.discount,
  });

  factory TeachingLevelModel.fromMap(Map<String, dynamic> map) {
    return TeachingLevelModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      subject: map['subject']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: map['price']?.toString() ?? '0.00',
      discount: map['discount']?.toString() ?? '0.00',
    );
  }
}
