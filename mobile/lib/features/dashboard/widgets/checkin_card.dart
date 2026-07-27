import 'package:flutter/material.dart';

class CheckinCard extends StatelessWidget {
  final String weight;
  final String water;
  final String sleep;
  final String mood;

  final VoidCallback onWeightTap;
  final VoidCallback onWaterTap;
  final VoidCallback onSleepTap;
  final VoidCallback onMoodTap;

  const CheckinCard({
    super.key,
    required this.weight,
    required this.water,
    required this.sleep,
    required this.mood,
    required this.onWeightTap,
    required this.onWaterTap,
    required this.onSleepTap,
    required this.onMoodTap,
  });

  Widget buildTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withValues(alpha:0.2),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: color.withValues(alpha:0.2),
          ),
        ),
        child: Column(
          children: [

            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha:0.2),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
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
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Row(
              children: [

                Icon(
                  Icons.fact_check,
                  color: Color(0xff0F766E),
                ),

                SizedBox(width: 10),

                Text(
                  "Today's Check-in",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: .95,

              children: [

                buildTile(
                  icon: Icons.monitor_weight,
                  title: "Weight",
                  value: weight,
                  color: Colors.blue,
                  onTap: onWeightTap,
                ),

                buildTile(
                  icon: Icons.water_drop,
                  title: "Water",
                  value: water,
                  color: Colors.cyan,
                  onTap: onWaterTap,
                ),

                buildTile(
                  icon: Icons.bedtime,
                  title: "Sleep",
                  value: sleep,
                  color: Colors.deepPurple,
                  onTap: onSleepTap,
                ),

                buildTile(
                  icon: Icons.emoji_emotions,
                  title: "Mood",
                  value: mood,
                  color: Colors.orange,
                  onTap: onMoodTap,
                ),
              ],
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffF0FDFA),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [

                  Icon(
                    Icons.info_outline,
                    color: Color(0xff0F766E),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Complete your daily check-in to improve your Health Score and receive better AI insights.",
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