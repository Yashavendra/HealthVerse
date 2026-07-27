import 'package:shared_preferences/shared_preferences.dart';

import '../screens/dashboard_model.dart';

class DashboardService {
  Future<DashboardModel> getDashboardData() async {
    final prefs = await SharedPreferences.getInstance();

    const double defaultHeight = 172;
    const double defaultWeight = 74;
    const double defaultTargetWeight = 68;
    const int defaultAge = 21;
    const String defaultGender = "Male";
    const String defaultGoal = "Lose Weight";
    const String defaultHealthFocus = "Weight Loss";

    final double height = prefs.getDouble('dashboard_height') ?? defaultHeight;
    final double weight = prefs.getDouble('dashboard_weight') ?? defaultWeight;
    final double targetWeight =
        prefs.getDouble('dashboard_targetWeight') ?? defaultTargetWeight;
    final int age = prefs.getInt('dashboard_age') ?? defaultAge;
    final String gender = prefs.getString('dashboard_gender') ?? defaultGender;
    final String goal = prefs.getString('dashboard_goal') ?? defaultGoal;
    final String healthFocus =
        prefs.getString('dashboard_healthFocus') ?? defaultHealthFocus;

    final bmi = calculateBMI(
      height: height,
      weight: weight,
    );

    final bmr = calculateBMR(
      age: age,
      height: height,
      weight: weight,
      gender: gender,
    );

    final double todayWater = prefs.getDouble('dashboard_todayWater') ?? 2.4;
    final double todaySleep = prefs.getDouble('dashboard_todaySleep') ?? 7.5;
    final int todaySteps = prefs.getInt('dashboard_todaySteps') ?? 8500;
    final int todayCalories = prefs.getInt('dashboard_todayCalories') ?? 1650;
    final double todayProtein = prefs.getDouble('dashboard_todayProtein') ?? 75;
    final double todayCarbs = prefs.getDouble('dashboard_todayCarbs') ?? 180;
    final double todayFat = prefs.getDouble('dashboard_todayFat') ?? 55;
    final String mood = prefs.getString('dashboard_mood') ?? "Happy";
    final int exerciseMinutes = prefs.getInt('dashboard_exerciseMinutes') ?? 45;
    final int stressLevel = prefs.getInt('dashboard_stressLevel') ?? 20;
    final String notes = prefs.getString('dashboard_notes') ??
        "Feeling energetic today.";

    final healthScore = calculateHealthScore(
      sleepHours: todaySleep,
      waterLitres: todayWater,
      steps: todaySteps,
      mood: mood,
      calories: todayCalories,
    );

    return DashboardModel(
      //---------------- USER ----------------//

      userName: prefs.getString('dashboard_userName') ?? "Yashavendra",
      age: prefs.getInt('dashboard_age') ?? defaultAge,
      gender: prefs.getString('dashboard_gender') ?? defaultGender,

      //---------------- BODY ----------------//

      height: height,
      weight: weight,
      bmi: bmi,
      bmr: bmr,

      //---------------- GOAL ----------------//

      goal: goal,
      healthFocus: healthFocus,
      targetWeight: targetWeight,
      goalProgress: calculateGoalProgress(
        currentWeight: weight,
        targetWeight: targetWeight,
      ),

      //---------------- HEALTH SCORE ----------------//

      overallHealthScore: healthScore,

      sleepScore: calculateSleepScore(todaySleep),

      waterScore: calculateWaterScore(todayWater),

      activityScore: calculateActivityScore(todaySteps),

      nutritionScore: calculateNutritionScore(todayCalories),

      mentalHealthScore: calculateMoodScore(mood),

      //---------------- TODAY ----------------//

      todayWater: todayWater,

      todaySleep: todaySleep,

      todaySteps: todaySteps,

      todayCalories: todayCalories,

      todayProtein: todayProtein,

      todayCarbs: todayCarbs,

      todayFat: todayFat,

      exerciseMinutes: exerciseMinutes,

      mood: mood,

      stressLevel: stressLevel,

      notes: notes,

      //---------------- VITALS ----------------//

      bloodPressure: "120/80",

      bloodSugar: 92,

      heartRate: 74,

      //---------------- AI ----------------//

      aiTitle: "Hydration Improving",

      aiDescription:
          "Your water intake has improved this week. Keep drinking 500 ml more to reach your ideal goal.",

      aiPriority: "Medium",

      aiRecommendation:
          "Walk for 20 minutes after dinner and drink one more glass of water.",

      //---------------- APP ----------------//

      streak: 12,

      notifications: 3,

      lastUpdated: DateTime.now(),
    );
  }

  //==================================================
  // BMI
  //==================================================

  double calculateBMI({
    required double height,
    required double weight,
  }) {
    final meter = height / 100;

    return weight / (meter * meter);
  }

  //==================================================
  // BMR
  //==================================================

  double calculateBMR({
    required int age,
    required double height,
    required double weight,
    required String gender,
  }) {
    if (gender == "Male") {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    }

    return 10 * weight + 6.25 * height - 5 * age - 161;
  }

  Future<void> saveDailyEntry({
    required double weight,
    required double todayWater,
    required double todaySleep,
    required int todaySteps,
    required int todayCalories,
    required double todayProtein,
    required double todayCarbs,
    required double todayFat,
    required int exerciseMinutes,
    required String mood,
    required int stressLevel,
    required String notes,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('dashboard_weight', weight);
    await prefs.setDouble('dashboard_todayWater', todayWater);
    await prefs.setDouble('dashboard_todaySleep', todaySleep);
    await prefs.setInt('dashboard_todaySteps', todaySteps);
    await prefs.setInt('dashboard_todayCalories', todayCalories);
    await prefs.setDouble('dashboard_todayProtein', todayProtein);
    await prefs.setDouble('dashboard_todayCarbs', todayCarbs);
    await prefs.setDouble('dashboard_todayFat', todayFat);
    await prefs.setInt('dashboard_exerciseMinutes', exerciseMinutes);
    await prefs.setString('dashboard_mood', mood);
    await prefs.setInt('dashboard_stressLevel', stressLevel);
    await prefs.setString('dashboard_notes', notes);
    await prefs.setString(
      'dashboard_lastUpdated',
      DateTime.now().toIso8601String(),
    );
  }

  //==================================================
  // Goal Progress
  //==================================================

  double calculateGoalProgress({
    required double currentWeight,
    required double targetWeight,
  }) {
    if (currentWeight <= targetWeight) {
      return 1;
    }

    final progress =
        targetWeight / currentWeight;

    return progress.clamp(0.0, 1.0);
  }

  //==================================================
  // Health Score
  //==================================================

  int calculateHealthScore({
    required double sleepHours,
    required double waterLitres,
    required int steps,
    required int calories,
    required String mood,
  }) {
    int score = 0;

    //---------------- Sleep ----------------//

    if (sleepHours >= 8) {
      score += 20;
    } else if (sleepHours >= 7) {
      score += 16;
    } else {
      score += 8;
    }

    //---------------- Water ----------------//

    if (waterLitres >= 3) {
      score += 20;
    } else if (waterLitres >= 2) {
      score += 16;
    } else {
      score += 8;
    }

    //---------------- Steps ----------------//

    if (steps >= 10000) {
      score += 20;
    } else if (steps >= 7000) {
      score += 16;
    } else {
      score += 8;
    }

    //---------------- Mood ----------------//

    if (mood == "Happy") {
      score += 20;
    } else if (mood == "Normal") {
      score += 16;
    } else {
      score += 8;
    }

    //---------------- Nutrition ----------------//

    if (calories >= 1800 && calories <= 2200) {
      score += 20;
    } else if (calories >= 1500 && calories <= 2500) {
      score += 16;
    } else {
      score += 8;
    }

    return score;
  }

  int calculateSleepScore(double sleepHours) {
    if (sleepHours >= 8) {
      return 95;
    }
    if (sleepHours >= 7) {
      return 80;
    }
    return 60;
  }

  int calculateWaterScore(double waterLitres) {
    if (waterLitres >= 3) {
      return 95;
    }
    if (waterLitres >= 2) {
      return 80;
    }
    return 60;
  }

  int calculateActivityScore(int steps) {
    if (steps >= 10000) {
      return 95;
    }
    if (steps >= 7000) {
      return 80;
    }
    return 60;
  }

  int calculateNutritionScore(int calories) {
    if (calories >= 1800 && calories <= 2200) {
      return 95;
    }
    if (calories >= 1500 && calories <= 2500) {
      return 80;
    }
    return 60;
  }

  int calculateMoodScore(String mood) {
    if (mood == "Happy") {
      return 95;
    }
    if (mood == "Normal") {
      return 80;
    }
    return 60;
  }

  //==================================================
  // BMI Category
  //==================================================

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    }

    if (bmi < 25) {
      return "Normal";
    }

    if (bmi < 30) {
      return "Overweight";
    }

    return "Obese";
  }

  //==================================================
  // Greeting
  //==================================================

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    }

    if (hour < 17) {
      return "Good Afternoon";
    }

    return "Good Evening";
  }
}
