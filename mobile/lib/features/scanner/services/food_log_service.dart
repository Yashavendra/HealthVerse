import '../models/scanned_food.dart';

class FoodLogService {
  FoodLogService();

  FoodLogService._();

  static final FoodLogService instance = FoodLogService._();

  final List<ScannedFood> _foodLogs = [];

  List<ScannedFood> getAllMeals() {
    return List.unmodifiable(_foodLogs);
  }

  void addMeal(ScannedFood meal) {
    _foodLogs.add(meal);
  }

  void removeMeal(String id) {
    _foodLogs.removeWhere((meal) => meal.id == id);
  }

  void updateMeal(ScannedFood updatedMeal) {
    final index =
        _foodLogs.indexWhere((meal) => meal.id == updatedMeal.id);

    if (index != -1) {
      _foodLogs[index] = updatedMeal;
    }
  }

  List<ScannedFood> getTodayMeals() {
    final now = DateTime.now();

    return _foodLogs.where((meal) {
      return meal.scannedAt.year == now.year &&
          meal.scannedAt.month == now.month &&
          meal.scannedAt.day == now.day;
    }).toList();
  }

  double getTodayCalories() {
    return getTodayMeals().fold(
      0,
      (sum, meal) => sum + meal.calories,
    );
  }

  double getTodayProtein() {
    return getTodayMeals().fold(
      0,
      (sum, meal) => sum + meal.protein,
    );
  }

  double getTodayCarbs() {
    return getTodayMeals().fold(
      0,
      (sum, meal) => sum + meal.carbs,
    );
  }

  double getTodayFat() {
    return getTodayMeals().fold(
      0,
      (sum, meal) => sum + meal.fat,
    );
  }

  Future<List<Map<String, dynamic>>> getLogsForDate(DateTime date) async {
    return _foodLogs
        .where((meal) {
          return meal.scannedAt.year == date.year &&
              meal.scannedAt.month == date.month &&
              meal.scannedAt.day == date.day;
        })
        .map((meal) => {
              'id': meal.id,
              'name': meal.foodName,
              'calories': meal.calories,
              'protein': meal.protein,
              'carbs': meal.carbs,
              'fat': meal.fat,
              'imagePath': meal.imagePath,
              'timestamp': meal.scannedAt.millisecondsSinceEpoch,
            })
        .toList();
  }

  Future<Map<String, double>> aggregateForDate(DateTime date) async {
    final logs = await getLogsForDate(date);

    return {
      'calories': logs.fold(0.0, (sum, item) => sum + (item['calories'] as num).toDouble()),
      'protein': logs.fold(0.0, (sum, item) => sum + (item['protein'] as num).toDouble()),
      'carbs': logs.fold(0.0, (sum, item) => sum + (item['carbs'] as num).toDouble()),
      'fat': logs.fold(0.0, (sum, item) => sum + (item['fat'] as num).toDouble()),
    };
  }

  Future<void> insertLog(Map<String, dynamic> log) async {
    final meal = ScannedFood(
      id: log['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
      foodName: log['name']?.toString() ?? 'Unknown',
      mealType: log['mealType']?.toString() ?? 'Meal',
      imagePath: log['imagePath']?.toString() ?? '',
      calories: _asNum(log['calories']).toDouble(),
      protein: _asNum(log['protein']).toDouble(),
      carbs: _asNum(log['carbs']).toDouble(),
      fat: _asNum(log['fat']).toDouble(),
      fiber: _asNum(log['fiber']).toDouble(),
      sugar: _asNum(log['sugar']).toDouble(),
      sodium: _asNum(log['sodium']).toDouble(),
      servingSize: _asNum(log['servingSize']).toDouble(),
      servingUnit: log['servingUnit']?.toString() ?? 'serving',
      confidence: _asNum(log['confidence']).toDouble(),
      aiVerified: log['aiVerified'] as bool? ?? false,
      scannedAt: log['timestamp'] is int
          ? DateTime.fromMillisecondsSinceEpoch(log['timestamp'] as int)
          : DateTime.now(),
    );

    addMeal(meal);
  }

  void clearAll() {
    _foodLogs.clear();
  }

  num _asNum(dynamic value) => value is num ? value : num.tryParse('$value') ?? 0;
}