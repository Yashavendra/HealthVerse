import 'package:flutter/material.dart';

class GoalProgressCard extends StatelessWidget {
  final String goalName;
  final double currentValue;
  final double targetValue;
  final String unit;
  final int estimatedDays;

  const GoalProgressCard({
    super.key,
    required this.goalName,
    required this.currentValue,
    required this.targetValue,
    required this.unit,
    required this.estimatedDays,
  });

  double get progress {
    if (currentValue <= 0 || targetValue <= 0) {
      return 0;
    }

    double value = currentValue / targetValue;

    if (value > 1) value = 1;

    return value;
  }

  double get remaining {
    double value = targetValue - currentValue;

    if (value < 0) {
      return 0;
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: const [

                Icon(
                  Icons.flag,
                  color: Color(0xff0F766E),
                ),

                SizedBox(width: 10),

                Text(
                  "Goal Progress",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Text(
              goalName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha:0.2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [

                        const Text(
                          "Current",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "${currentValue.toStringAsFixed(1)} $unit",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha:0.2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [

                        const Text(
                          "Target",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "${targetValue.toStringAsFixed(1)} $unit",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 14,
                color: const Color(0xff0F766E),
                backgroundColor: Colors.grey.shade300,
              ),
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            const Divider(height: 35),

            Row(
              children: [

                const Icon(
                  Icons.track_changes,
                  color: Colors.orange,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    "Remaining : ${remaining.toStringAsFixed(1)} $unit",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                const Icon(
                  Icons.schedule,
                  color: Colors.deepPurple,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    "Estimated completion : $estimatedDays days",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                    Icons.smart_toy,
                    color: Color(0xff0F766E),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "AI updates this goal automatically based on your journal entries.",
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