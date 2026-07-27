import 'package:flutter/material.dart';

class HealthScoreCard extends StatelessWidget {
  final int score;

  final int sleepScore;
  final int waterScore;
  final int activityScore;
  final int moodScore;

  const HealthScoreCard({
    super.key,
    required this.score,
    required this.sleepScore,
    required this.waterScore,
    required this.activityScore,
    required this.moodScore,
  });

  Color get scoreColor {
    if (score >= 85) return Colors.green;

    if (score >= 70) return Colors.orange;

    return Colors.red;
  }

  String get healthStatus {
    if (score >= 85) {
      return "Excellent";
    }

    if (score >= 70) {
      return "Good";
    }

    return "Needs Improvement";
  }

  String get aiRemark {
    if (score >= 85) {
      return "You're doing a great job! Keep maintaining your healthy habits.";
    }

    if (score >= 70) {
      return "You're on the right track. Small improvements can boost your health.";
    }

    return "Let's improve your daily routine step by step.";
  }

  Widget buildMetric(
    String title,
    int value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: color.withValues(alpha:0.2),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [

            Icon(
              icon,
              color: color,
              size: 30,
            ),

            const SizedBox(height: 10),

            Text(
              "$value%",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,

      shadowColor: Colors.black12,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),

      child: Padding(
        padding: const EdgeInsets.all(22),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Row(
              children: [

                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),

                SizedBox(width: 10),

                Text(
                  "Health Score",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [

                  SizedBox(
                    width: 140,
                    height: 140,

                    child: CircularProgressIndicator(
                      value: score / 100,
                      strokeWidth: 12,
                      color: scoreColor,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),

                  Column(
                    children: [

                      Text(
                        "$score",
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        "/100",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Center(
              child: Text(
                healthStatus,
                style: TextStyle(
                  color: scoreColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                aiRemark,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 20),

            Row(
              children: [

                buildMetric(
                  "Sleep",
                  sleepScore,
                  Icons.bedtime,
                  Colors.deepPurple,
                ),

                buildMetric(
                  "Water",
                  waterScore,
                  Icons.water_drop,
                  Colors.blue,
                ),
              ],
            ),

            Row(
              children: [

                buildMetric(
                  "Activity",
                  activityScore,
                  Icons.directions_walk,
                  Colors.green,
                ),

                buildMetric(
                  "Mood",
                  moodScore,
                  Icons.emoji_emotions,
                  Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: const Color(0xffF0FDFA),
                borderRadius: BorderRadius.circular(18),
              ),

              child: const Row(
                children: [

                  Icon(
                    Icons.lightbulb,
                    color: Color(0xff0F766E),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "AI will calculate your Health Score automatically based on your daily journal entries.",
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}