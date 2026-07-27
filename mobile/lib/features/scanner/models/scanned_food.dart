class ScannedFood {
  final String id;

  final String foodName;

  final String mealType;

  final String imagePath;

  final double calories;

  final double protein;

  final double carbs;

  final double fat;

  final double fiber;

  final double sugar;

  final double sodium;

  final double servingSize;

  final String servingUnit;

  final double confidence;

  final bool aiVerified;

  final DateTime scannedAt;

  const ScannedFood({
    required this.id,
    required this.foodName,
    required this.mealType,
    required this.imagePath,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    required this.servingSize,
    required this.servingUnit,
    required this.confidence,
    required this.aiVerified,
    required this.scannedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "foodName": foodName,
      "mealType": mealType,
      "imagePath": imagePath,
      "calories": calories,
      "protein": protein,
      "carbs": carbs,
      "fat": fat,
      "fiber": fiber,
      "sugar": sugar,
      "sodium": sodium,
      "servingSize": servingSize,
      "servingUnit": servingUnit,
      "confidence": confidence,
      "aiVerified": aiVerified,
      "scannedAt": scannedAt.toIso8601String(),
    };
  }

  factory ScannedFood.fromMap(Map<String, dynamic> map) {
    return ScannedFood(
      id: map["id"],
      foodName: map["foodName"],
      mealType: map["mealType"],
      imagePath: map["imagePath"],
      calories: (map["calories"] as num).toDouble(),
      protein: (map["protein"] as num).toDouble(),
      carbs: (map["carbs"] as num).toDouble(),
      fat: (map["fat"] as num).toDouble(),
      fiber: (map["fiber"] as num).toDouble(),
      sugar: (map["sugar"] as num).toDouble(),
      sodium: (map["sodium"] as num).toDouble(),
      servingSize: (map["servingSize"] as num).toDouble(),
      servingUnit: map["servingUnit"],
      confidence: (map["confidence"] as num).toDouble(),
      aiVerified: map["aiVerified"],
      scannedAt: DateTime.parse(map["scannedAt"]),
    );
  }

  ScannedFood copyWith({
    String? id,
    String? foodName,
    String? mealType,
    String? imagePath,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? fiber,
    double? sugar,
    double? sodium,
    double? servingSize,
    String? servingUnit,
    double? confidence,
    bool? aiVerified,
    DateTime? scannedAt,
  }) {
    return ScannedFood(
      id: id ?? this.id,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
      imagePath: imagePath ?? this.imagePath,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      sugar: sugar ?? this.sugar,
      sodium: sodium ?? this.sodium,
      servingSize: servingSize ?? this.servingSize,
      servingUnit: servingUnit ?? this.servingUnit,
      confidence: confidence ?? this.confidence,
      aiVerified: aiVerified ?? this.aiVerified,
      scannedAt: scannedAt ?? this.scannedAt,
    );
  }
}