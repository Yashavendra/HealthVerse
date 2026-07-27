import 'package:flutter/material.dart';

class AIInsightCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final VoidCallback? onViewDetails;

  const AIInsightCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.onViewDetails,
  });

  Color get priorityColor {
    switch (priority.toLowerCase()) {
      case "high":
        return Colors.red;
      case "medium":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  IconData get priorityIcon {
    switch (priority.toLowerCase()) {
      case "high":
        return Icons.warning_rounded;
      case "medium":
        return Icons.error_outline;
      default:
        return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xffE6FFFA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.smart_toy,
                    color: Color(0xff0F766E),
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    "AI Health Insight",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              description,
              style: const TextStyle(
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [

                      Icon(
                        priorityIcon,
                        size: 18,
                        color: priorityColor,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        "$priority Priority",
                        style: TextStyle(
                          color: priorityColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                FilledButton.icon(
                  onPressed: onViewDetails,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xff0F766E),
                  ),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("View"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}