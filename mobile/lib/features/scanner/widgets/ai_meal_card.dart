import 'package:flutter/material.dart';

class AIMealCard extends StatelessWidget {
  const AIMealCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff0F766E),
            Color(0xff14B8A6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: .25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Row(
            children: const [
              Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: 10),
              Text(
                "AI Meal Scanner",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "Capture or upload your food photo.\nAI will automatically detect nutrition.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 22),

          /// CALORIE CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [

                Row(
                  children: const [

                    Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                    ),

                    SizedBox(width: 10),

                    Text(
                      "Today's Calories",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Spacer(),

                    Text(
                      "0 / 2500 kcal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const LinearProgressIndicator(
                    value: 0,
                    minHeight: 8,
                    backgroundColor: Colors.white24,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// BUTTONS
          Row(
            children: [

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Camera integration coming soon.",
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xff0F766E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Gallery integration coming soon.",
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Gallery"),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          /// AI INFO
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Icon(
                  Icons.tips_and_updates,
                  color: Colors.amber,
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Text(
                    "AI will identify your meal, calculate calories, protein, carbs and fat, then automatically update your Daily Dashboard.",
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}