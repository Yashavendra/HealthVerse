import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F766E),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Reports'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Health Reports',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Review your progress and key health metrics in one place.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: ListView(
                  children: const [
                    _ReportCard(
                      title: 'Weekly Summary',
                      subtitle: 'Your last 7 days of activity and wellness.',
                    ),
                    _ReportCard(
                      title: 'Sleep Insights',
                      subtitle: 'Sleep patterns and rest quality.',
                    ),
                    _ReportCard(
                      title: 'Hydration Tracker',
                      subtitle: 'Daily water consumption trends.',
                    ),
                    _ReportCard(
                      title: 'Mood Overview',
                      subtitle: 'Emotional well-being checks and trends.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ReportCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title coming soon')),
          );
        },
      ),
    );
  }
}
