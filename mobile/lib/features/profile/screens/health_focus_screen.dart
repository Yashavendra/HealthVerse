import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthFocusScreen extends StatefulWidget {
  const HealthFocusScreen({super.key});

  @override
  State<HealthFocusScreen> createState() => _HealthFocusScreenState();
}

class _HealthFocusScreenState extends State<HealthFocusScreen> {
  final List<String> selectedFocus = [];

  final List<Map<String, dynamic>> focusList = [
    {
      "title": "Weight Loss",
      "subtitle": "Lose weight in a healthy way",
      "icon": Icons.monitor_weight_outlined,
      "active": true,
    },
    {
      "title": "Weight Gain",
      "subtitle": "Healthy weight gain plan",
      "icon": Icons.fitness_center,
      "active": true,
    },
    {
      "title": "Muscle Building",
      "subtitle": "Workout & nutrition tracking",
      "icon": Icons.sports_gymnastics,
      "active": true,
    },
    {
      "title": "Hair Care",
      "subtitle": "Track hair health & progress",
      "icon": Icons.face,
      "active": true,
    },
    {
      "title": "Daily Health Journal",
      "subtitle": "Coming soon",
      "icon": Icons.menu_book_rounded,
      "active": false,
    },
    {
      "title": "Better Sleep",
      "subtitle": "Coming soon",
      "icon": Icons.bedtime,
      "active": false,
    },
    {
      "title": "Diabetes Care",
      "subtitle": "Coming soon",
      "icon": Icons.bloodtype,
      "active": false,
    },
    {
      "title": "Blood Pressure",
      "subtitle": "Coming soon",
      "icon": Icons.favorite,
      "active": false,
    },
    {
      "title": "Mental Wellness",
      "subtitle": "Coming soon",
      "icon": Icons.psychology,
      "active": false,
    },
  ];

  void toggleSelection(String title) {
    setState(() {
      if (selectedFocus.contains(title)) {
        selectedFocus.remove(title);
      } else {
        selectedFocus.add(title);
      }
    });
  }

  Future<void> _continue() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('dashboard_healthFocus', selectedFocus.join(', '));
    await preferences.setString('dashboard_goal', selectedFocus.first);
    if (!mounted) return;
    context.go('/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Health Focus"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Choose your Health Focus",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              selectedFocus.isEmpty
                  ? "Select at least one focus to continue."
                  : "You can select multiple options.",
              style: TextStyle(
                color: selectedFocus.isEmpty ? Colors.redAccent : Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: focusList.length,
                itemBuilder: (context, index) {

                  final item = focusList[index];
                  final selected =
                      selectedFocus.contains(item["title"]);
                  final isActive = item["active"] == true;

                  return Card(
                    elevation: selected ? 8 : 2,
                    color: selected
                        ? const Color(0xff0F766E)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: selected
                            ? const Color(0xff0F766E)
                            : const Color(0xffE5E7EB),
                        width: selected ? 1.8 : 1,
                      ),
                    ),
                    child: ListTile(
                      enabled: isActive,
                      onTap: isActive
                          ? () => toggleSelection(item["title"])
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      tileColor: isActive
                          ? (selected ? const Color(0xff0F766E) : Colors.white)
                          : const Color(0xffF3F4F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: selected
                            ? Colors.white24
                            : const Color(0xffEEF2FF),
                        child: Icon(
                          item["icon"],
                          color: isActive
                              ? (selected ? Colors.white : const Color(0xff0F766E))
                              : Colors.grey,
                        ),
                      ),
                      title: Text(
                        item["title"],
                        style: TextStyle(
                          color: isActive
                              ? (selected ? Colors.white : Colors.black)
                              : Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        item["subtitle"],
                        style: TextStyle(
                          color: isActive
                              ? (selected ? Colors.white70 : Colors.grey)
                              : Colors.grey.shade500,
                        ),
                      ),
                      trailing: isActive
                          ? (selected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.circle_outlined,
                                  color: Color(0xff0F766E),
                                ))
                          : const Text(
                              'Coming soon',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedFocus.isNotEmpty
                      ? const Color(0xff0F766E)
                      : Colors.grey.shade400,
                ),
                onPressed: selectedFocus.isNotEmpty
                    ? _continue
                    : null,
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
