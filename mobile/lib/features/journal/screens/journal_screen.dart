import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: const Color(0xff0F766E),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("Daily Journal"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Track Your Health",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Record your daily health activities and let AI analyze your progress.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 35),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 1.05,

                children: const [

                  _JournalCard(
                    icon: Icons.water_drop,
                    color: Colors.blue,
                    title: "Water",
                  ),

                  _JournalCard(
                    icon: Icons.hotel,
                    color: Colors.deepPurple,
                    title: "Sleep",
                  ),

                  _JournalCard(
                    icon: Icons.monitor_weight,
                    color: Colors.green,
                    title: "Weight",
                  ),

                  _JournalCard(
                    icon: Icons.emoji_emotions,
                    color: Colors.orange,
                    title: "Mood",
                  ),

                  _JournalCard(
                    icon: Icons.fitness_center,
                    color: Colors.red,
                    title: "Workout",
                  ),

                  _JournalCard(
                    icon: Icons.medication,
                    color: Colors.teal,
                    title: "Medicine",
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff0F766E),
        foregroundColor: Colors.white,
        onPressed: () {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Journal Entry Screen Coming Soon"),
            ),
          );

        },
        icon: const Icon(Icons.add),
        label: const Text("Add Entry"),
      ),
    );
  }
}

class _JournalCard extends StatelessWidget {

  final IconData icon;
  final Color color;
  final String title;

  const _JournalCard({
    required this.icon,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$title module coming soon"),
            ),
          );

        },

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: color.withValues(alpha: .15),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}