class UserProfile {
  final String fullName;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String activityLevel;
  final List<String> healthFocus;

  UserProfile({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.healthFocus,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'activityLevel': activityLevel,
      'healthFocus': healthFocus,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      fullName: map['fullName'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      height: (map['height'] ?? 0).toDouble(),
      weight: (map['weight'] ?? 0).toDouble(),
      activityLevel: map['activityLevel'] ?? '',
      healthFocus: List<String>.from(map['healthFocus'] ?? []),
    );
  }
}