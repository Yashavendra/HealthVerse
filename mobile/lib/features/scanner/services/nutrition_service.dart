import '../models/scanned_food.dart';

class NutritionService {
  NutritionService();

  NutritionService._();

  static final NutritionService instance = NutritionService._();

  final List<String> sampleFoods = const [
    'Apple',
    'Banana',
    'Chicken Bowl',
    'Salad',
    'Pizza',
    'Orange Juice',
  ];

  // Default Daily Goals
  static const double dailyCaloriesGoal = 2500;
  static const double dailyProteinGoal = 120;
  static const double dailyCarbsGoal = 300;
  static const double dailyFatGoal = 70;
  static const double dailyWaterGoal = 3.0;

  double totalCalories(List<ScannedFood> meals) {
    return meals.fold(
      0,
      (sum, meal) => sum + meal.calories,
    );
  }

  double totalProtein(List<ScannedFood> meals) {
    return meals.fold(
      0,
      (sum, meal) => sum + meal.protein,
    );
  }

  double totalCarbs(List<ScannedFood> meals) {
    return meals.fold(
      0,
      (sum, meal) => sum + meal.carbs,
    );
  }

  double totalFat(List<ScannedFood> meals) {
    return meals.fold(
      0,
      (sum, meal) => sum + meal.fat,
    );
  }

  double calorieProgress(List<ScannedFood> meals) {
    final total = totalCalories(meals);
    return (total / dailyCaloriesGoal).clamp(0.0, 1.0);
  }

  double proteinProgress(List<ScannedFood> meals) {
    final total = totalProtein(meals);
    return (total / dailyProteinGoal).clamp(0.0, 1.0);
  }

  double carbsProgress(List<ScannedFood> meals) {
    final total = totalCarbs(meals);
    return (total / dailyCarbsGoal).clamp(0.0, 1.0);
  }

  double fatProgress(List<ScannedFood> meals) {
    final total = totalFat(meals);
    return (total / dailyFatGoal).clamp(0.0, 1.0);
  }

  double remainingCalories(List<ScannedFood> meals) {
    return dailyCaloriesGoal - totalCalories(meals);
  }

  double remainingProtein(List<ScannedFood> meals) {
    return dailyProteinGoal - totalProtein(meals);
  }

  double remainingCarbs(List<ScannedFood> meals) {
    return dailyCarbsGoal - totalCarbs(meals);
  }

  double remainingFat(List<ScannedFood> meals) {
    return dailyFatGoal - totalFat(meals);
  }

  int healthScore(List<ScannedFood> meals) {
    double score = 100;

    final calories = totalCalories(meals);

    if (calories > dailyCaloriesGoal) {
      score -= 20;
    }

    if (totalProtein(meals) < 60) {
      score -= 10;
    }

    if (totalFat(meals) > 90) {
      score -= 10;
    }

    if (score < 0) score = 0;

    return score.round();
  }

  String mealQuality(List<ScannedFood> meals) {
    final score = healthScore(meals);

    if (score >= 90) {
      return 'Excellent';
    }

    if (score >= 75) {
      return 'Good';
    }

    if (score >= 60) {
      return 'Average';
    }

    return 'Needs Improvement';
  }

  Map<String, dynamic> lookupFood(String text) {
    final query = text.trim().toLowerCase();

    if (query.contains('banana')) {
      return {
        'name': 'Banana',
        'calories': 105,
        'protein': 1.3,
        'carbs': 27,
        'fat': 0.3,
      };
    }

    if (query.contains('chicken')) {
      return {
        'name': 'Chicken Bowl',
        'calories': 540,
        'protein': 38,
        'carbs': 45,
        'fat': 18,
      };
    }

    if (query.contains('salad')) {
      return {
        'name': 'Salad',
        'calories': 220,
        'protein': 8,
        'carbs': 18,
        'fat': 12,
      };
    }

    if (query.contains('pizza')) {
      return {
        'name': 'Pizza',
        'calories': 285,
        'protein': 12,
        'carbs': 36,
        'fat': 10,
      };
    }

    if (query.contains('juice')) {
      return {
        'name': 'Orange Juice',
        'calories': 112,
        'protein': 1.7,
        'carbs': 26,
        'fat': 0.5,
      };
    }

    return {
      'name': 'Apple',
      'calories': 95,
      'protein': 0.5,
      'carbs': 25,
      'fat': 0.3,
    };
  }
}