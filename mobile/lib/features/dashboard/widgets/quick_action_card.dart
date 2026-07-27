import 'package:flutter/material.dart';

class QuickActionCard extends StatelessWidget {
  final VoidCallback onJournal;
  final VoidCallback onAI;
  final VoidCallback onMedicine;
  final VoidCallback onReports;
  final VoidCallback onScanner;
  final VoidCallback onReminder;
  final VoidCallback onProfile;
  final VoidCallback onSettings;

  const QuickActionCard({
    super.key,
    required this.onJournal,
    required this.onAI,
    required this.onMedicine,
    required this.onReports,
    required this.onScanner,
    required this.onReminder,
    required this.onProfile,
    required this.onSettings,
  });

  Widget buildItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha:0.2),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha:0.2),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
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
                  Icons.flash_on,
                  color: Color(0xff0F766E),
                ),

                SizedBox(width: 10),

                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              crossAxisCount: 4,

              crossAxisSpacing: 15,

              mainAxisSpacing: 15,

              childAspectRatio: .82,

              children: [

                buildItem(
                  icon: Icons.menu_book,
                  title: "Journal",
                  color: Colors.blue,
                  onTap: onJournal,
                ),

                buildItem(
                  icon: Icons.smart_toy,
                  title: "AI",
                  color: Colors.deepPurple,
                  onTap: onAI,
                ),

                buildItem(
                  icon: Icons.medication,
                  title: "Medicine",
                  color: Colors.red,
                  onTap: onMedicine,
                ),

                buildItem(
                  icon: Icons.bar_chart,
                  title: "Reports",
                  color: Colors.orange,
                  onTap: onReports,
                ),

                buildItem(
                  icon: Icons.document_scanner,
                  title: "Scanner",
                  color: Colors.teal,
                  onTap: onScanner,
                ),

                buildItem(
                  icon: Icons.alarm,
                  title: "Reminder",
                  color: Colors.pink,
                  onTap: onReminder,
                ),

                buildItem(
                  icon: Icons.person,
                  title: "Profile",
                  color: Colors.green,
                  onTap: onProfile,
                ),

                buildItem(
                  icon: Icons.settings,
                  title: "Settings",
                  color: Colors.grey,
                  onTap: onSettings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}