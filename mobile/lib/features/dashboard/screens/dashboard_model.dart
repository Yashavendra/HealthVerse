class DashboardModel {
  //==========================
  // USER INFORMATION
  //==========================

  final String userName;
  final int age;
  final String gender;

  //==========================
  // BODY INFORMATION
  //==========================

  final double height;
  final double weight;

  final double bmi;
  final double bmr;

  //==========================
  // HEALTH GOAL
  //==========================

  final String goal;

  final String healthFocus;

  final double targetWeight;

  final double goalProgress;

  //==========================
  // HEALTH SCORE
  //==========================

  final int overallHealthScore;

  final int sleepScore;

  final int waterScore;

  final int activityScore;

  final int nutritionScore;

  final int mentalHealthScore;

  //==========================
  // TODAY'S JOURNAL
  //==========================

  final double todayWater;

  final double todaySleep;

  final int todaySteps;
  final int todayCalories;

  final double todayProtein;

  final double todayCarbs;

  final double todayFat;
  final int exerciseMinutes;

  final String mood;

  final int stressLevel;

  final String notes;

  //==========================
  // HEALTH VITALS
  //==========================

  final String bloodPressure;

  final double bloodSugar;

  final int heartRate;

  //==========================
  // AI
  //==========================

  final String aiTitle;

  final String aiDescription;

  final String aiPriority;

  final String aiRecommendation;

  //==========================
  // APP INFO
  //==========================

  final int streak;

  final int notifications;

  final DateTime lastUpdated;

  const DashboardModel({
    // User
    required this.userName,
    required this.age,
    required this.gender,

    // Body
    required this.height,
    required this.weight,
    required this.bmi,
    required this.bmr,

    // Goal
    required this.goal,
    required this.healthFocus,
    required this.targetWeight,
    required this.goalProgress,

    // Health Score
    required this.overallHealthScore,
    required this.sleepScore,
    required this.waterScore,
    required this.activityScore,
    required this.nutritionScore,
    required this.mentalHealthScore,

    // Journal
    required this.todayWater,
    required this.todaySleep,
    required this.todaySteps,
    required this.todayCalories,
    required this.todayProtein,
    required this.todayCarbs,
    required this.todayFat,
    required this.exerciseMinutes,
    required this.mood,
    required this.stressLevel,
    required this.notes,

    // Vitals
    required this.bloodPressure,
    required this.bloodSugar,
    required this.heartRate,

    // AI
    required this.aiTitle,
    required this.aiDescription,
    required this.aiPriority,
    required this.aiRecommendation,

    // App
    required this.streak,
    required this.notifications,
    required this.lastUpdated,
  });
}