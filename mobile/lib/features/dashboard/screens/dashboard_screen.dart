import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'dashboard_model.dart';
import '../services/dashboard_service.dart';

import '../widgets/greeting_card.dart';
import '../widgets/health_score_card.dart';
import '../widgets/checkin_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/ai_insight_card.dart';
import '../widgets/goal_progress_card.dart';
import '../../scanner/widgets/ai_meal_card.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardModel? dashboard;
  bool isLoading = true;
  String? loadError;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    try {
      final data = await DashboardService().getDashboardData();
      if (!mounted) return;
      setState(() {
        dashboard = data;
        isLoading = false;
        loadError = null;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          isLoading = false;
          loadError = 'Unable to load dashboard data.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff0F766E),
        foregroundColor: Colors.white,
        onPressed: () async {
          final saved = await context.push<bool>('/daily-entry');

          if (saved == true) {
            if (!mounted) return;
            _loadDashboard();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Entry"),
      ),

      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : loadError != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(loadError!),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {
                            setState(() => isLoading = true);
                            _loadDashboard();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(

                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              //-------------------------------------------------
              // Greeting
              //-------------------------------------------------

              GreetingCard(
                userName: dashboard!.userName,
                streak: dashboard!.streak,
                notificationCount: dashboard!.notifications,
              ),

              const SizedBox(height: 20),

              const AIMealCard(),

              const SizedBox(height: 25),

              //-------------------------------------------------
              // Health Score
              //-------------------------------------------------

              HealthScoreCard(
                score: dashboard!.overallHealthScore,
                sleepScore: dashboard!.sleepScore,
                waterScore: dashboard!.waterScore,
                activityScore: dashboard!.activityScore,
                moodScore: dashboard!.mentalHealthScore,
              ),

              const SizedBox(height: 25),

              //-------------------------------------------------
              // Today's Check-in
              //-------------------------------------------------

              CheckinCard(
                weight:
                    "${dashboard!.weight.toStringAsFixed(1)} kg",

                water:
                    "${dashboard!.todayWater.toStringAsFixed(1)} L",

                sleep:
                    "${dashboard!.todaySleep.toStringAsFixed(1)} H",

                mood: dashboard!.mood,

                onWeightTap: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Weight screen coming soon",
                      ),
                    ),
                  );

                },

                onWaterTap: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Water tracker coming soon",
                      ),
                    ),
                  );

                },

                onSleepTap: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Sleep tracker coming soon",
                      ),
                    ),
                  );

                },

                onMoodTap: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Mood tracker coming soon",
                      ),
                    ),
                  );

                },
              ),

              const SizedBox(height: 25),
                            //-------------------------------------------------
              // Quick Actions
              //-------------------------------------------------

              QuickActionCard(
                onJournal: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Journal Screen Coming Soon"),
                    ),
                  );
                },

                onAI: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("AI Assistant Coming Soon"),
                    ),
                  );
                },

                onMedicine: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Medicine Tracker Coming Soon"),
                    ),
                  );
                },

                onReports: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Reports Coming Soon"),
                    ),
                  );
                },

                onScanner: () {
                  context.push('/scanner');
                },

                onReminder: () {
                  context.push('/food-log');
                },

                onProfile: () {
                  context.push('/profile');
                },

                onSettings: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Settings Coming Soon"),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              //-------------------------------------------------
              // AI Insight
              //-------------------------------------------------

              AIInsightCard(
                title: dashboard!.aiTitle,
                description: dashboard!.aiDescription,
                priority: dashboard!.aiPriority,
                onViewDetails: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Detailed AI Report Coming Soon"),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              //-------------------------------------------------
              // Goal Progress
              //-------------------------------------------------

              GoalProgressCard(
                goalName: dashboard!.goal,
                currentValue: dashboard!.weight,
                targetValue: dashboard!.targetWeight,
                unit: "kg",
                estimatedDays: 30,
              ),

              const SizedBox(height: 25),

              //-------------------------------------------------
              // Today's Summary
              //-------------------------------------------------

              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Today's Summary",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffE0F2FE),
                          child: Icon(
                            Icons.water_drop,
                            color: Colors.blue,
                          ),
                        ),
                        title: const Text("Water Intake"),
                        trailing: Text(
                          "${dashboard!.todayWater.toStringAsFixed(1)} L",
                        ),
                      ),

                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffEDE9FE),
                          child: Icon(
                            Icons.bedtime,
                            color: Colors.deepPurple,
                          ),
                        ),
                        title: const Text("Sleep"),
                        trailing: Text(
                          "${dashboard!.todaySleep.toStringAsFixed(1)} Hrs",
                        ),
                      ),

                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffDCFCE7),
                          child: Icon(
                            Icons.directions_walk,
                            color: Colors.green,
                          ),
                        ),
                        title: const Text("Steps"),
                        trailing: Text(
                          "${dashboard!.todaySteps}",
                        ),
                      ),

                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffFEF3C7),
                          child: Icon(
                            Icons.emoji_emotions,
                            color: Colors.orange,
                          ),
                        ),
                        title: const Text("Mood"),
                        trailing: Text(
                          dashboard!.mood,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nutrition Summary",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffFEF3C7),
                          child: Icon(
                            Icons.local_fire_department,
                            color: Colors.orange,
                          ),
                        ),
                        title: const Text("Calories"),
                        trailing: Text(
                          "${dashboard!.todayCalories} kcal",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffDCFCE7),
                          child: Icon(
                            Icons.egg,
                            color: Colors.green,
                          ),
                        ),
                        title: const Text("Protein"),
                        trailing: Text(
                          "${dashboard!.todayProtein.toStringAsFixed(1)} g",
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffDBEAFE),
                          child: Icon(
                            Icons.grain,
                            color: Colors.blue,
                          ),
                        ),
                        title: const Text("Carbs"),
                        trailing: Text(
                          "${dashboard!.todayCarbs.toStringAsFixed(1)} g",
                        ),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffFCE7F3),
                          child: Icon(
                            Icons.oil_barrel,
                            color: Colors.pink,
                          ),
                        ),
                        title: const Text("Fat"),
                        trailing: Text(
                          "${dashboard!.todayFat.toStringAsFixed(1)} g",
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
                            //-------------------------------------------------
              // Recent Activity
              //-------------------------------------------------

              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [

                      Text(
                        "Recent Activity",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),

                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffDCFCE7),
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                        title: Text("Daily Journal Completed"),
                        subtitle: Text("Today • 8:30 AM"),
                      ),

                      Divider(),

                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffDBEAFE),
                          child: Icon(
                            Icons.water_drop,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text("Water Goal Updated"),
                        subtitle: Text("2.4 L completed"),
                      ),

                      Divider(),

                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffFCE7F3),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          ),
                        ),
                        title: Text("Health Score Improved"),
                        subtitle: Text("+3 points this week"),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //-------------------------------------------------
              // Health Statistics
              //-------------------------------------------------

              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Health Statistics",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [

                          Expanded(
                            child: _statCard(
                              "BMI",
                              dashboard!.bmi.toStringAsFixed(1),
                              Colors.blue,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: _statCard(
                              "BMR",
                              dashboard!.bmr.toStringAsFixed(0),
                              Colors.orange,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [

                          Expanded(
                            child: _statCard(
                              "Heart Rate",
                              "${dashboard!.heartRate}",
                              Colors.red,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: _statCard(
                              "BP",
                              dashboard!.bloodPressure,
                              Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 100),

            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [

          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
