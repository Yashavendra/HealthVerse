import 'package:flutter/material.dart';

class GreetingCard extends StatelessWidget {
  final String userName;
  final int streak;
  final int notificationCount;

  const GreetingCard({
    super.key,
    required this.userName,
    required this.streak,
    this.notificationCount = 0,
  });

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    }

    if (hour < 17) {
      return "Good Afternoon";
    }

    return "Good Evening";
  }

  String _emoji() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "🌞";
    }

    if (hour < 17) {
      return "☀️";
    }

    return "🌙";
  }

  String _date() {
    final now = DateTime.now();

    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return "${now.day} ${months[now.month - 1]}, ${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff0F766E),
            Color(0xff14B8A6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha:0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: Text(
                  userName.isNotEmpty
                      ? userName[0].toUpperCase()
                      : "U",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xff0F766E),
                  ),
                ),
              ),

              const Spacer(),

              Stack(
                children: [

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha:0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                  ),

                  if (notificationCount > 0)
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            notificationCount > 9
                                ? "9+"
                                : "$notificationCount",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 25),

          Row(
            children: [

              Text(
                _emoji(),
                style: const TextStyle(fontSize: 26),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  _greeting(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),


          const Text(
            "Welcome back to HealthVerse",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [

              const Icon(
                Icons.calendar_today,
                color: Colors.white70,
                size: 18,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  _date(),
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [

                const Text(
                  "🔥",
                  style: TextStyle(fontSize: 22),
                ),

                const SizedBox(width: 10),

                Text(
                  "$streak Day Health Streak",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                const Spacer(),

                const Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}