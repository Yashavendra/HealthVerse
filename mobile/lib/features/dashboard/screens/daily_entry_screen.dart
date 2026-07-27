import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../services/dashboard_service.dart';

class DailyEntryScreen extends StatefulWidget {
  const DailyEntryScreen({super.key});

  @override
  State<DailyEntryScreen> createState() => _DailyEntryScreenState();
}

class _DailyEntryScreenState extends State<DailyEntryScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController waterController = TextEditingController();
  final TextEditingController sleepController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String selectedMood = 'Happy';
  bool isSaving = false;

  @override
  void dispose() {
    weightController.dispose();
    waterController.dispose();
    sleepController.dispose();
    stepsController.dispose();
    caloriesController.dispose();
    proteinController.dispose();
    carbsController.dispose();
    fatController.dispose();
    exerciseController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> saveEntry() async {
    final weight = double.tryParse(weightController.text.trim());
    final water = double.tryParse(waterController.text.trim());
    final sleep = double.tryParse(sleepController.text.trim());
    final steps = int.tryParse(stepsController.text.trim());
    final calories = int.tryParse(caloriesController.text.trim());
    final protein = double.tryParse(proteinController.text.trim());
    final carbs = double.tryParse(carbsController.text.trim());
    final fat = double.tryParse(fatController.text.trim());
    final exerciseMinutes = int.tryParse(exerciseController.text.trim());

    if (weight == null || weight <= 0) {
      _showError('Enter a valid weight.');
      return;
    }
    if (water == null || water <= 0) {
      _showError('Enter a valid water intake.');
      return;
    }
    if (sleep == null || sleep <= 0) {
      _showError('Enter a valid sleep duration.');
      return;
    }
    if (steps == null || steps < 0) {
      _showError('Enter a valid step count.');
      return;
    }
    if (calories == null || calories < 0) {
      _showError('Enter valid calories.');
      return;
    }
    if (protein == null || protein < 0) {
      _showError('Enter valid protein grams.');
      return;
    }
    if (carbs == null || carbs < 0) {
      _showError('Enter valid carb grams.');
      return;
    }
    if (fat == null || fat < 0) {
      _showError('Enter valid fat grams.');
      return;
    }
    if (exerciseMinutes == null || exerciseMinutes < 0) {
      _showError('Enter valid exercise minutes.');
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      await DashboardService().saveDailyEntry(
        weight: weight,
        todayWater: water,
        todaySleep: sleep,
        todaySteps: steps,
        todayCalories: calories,
        todayProtein: protein,
        todayCarbs: carbs,
        todayFat: fat,
        exerciseMinutes: exerciseMinutes,
        mood: selectedMood,
        stressLevel: 20,
        notes: notesController.text.trim().isEmpty
            ? 'No additional notes.'
            : notesController.text.trim(),
      );
    } catch (_) {
      if (mounted) {
        setState(() => isSaving = false);
        _showError('Unable to save the daily entry. Please try again.');
      }
      return;
    }

    if (!mounted) return;
    setState(() => isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Daily entry saved successfully.')),
    );
    context.pop(true);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget buildNumberField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool allowDecimal = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType:
          TextInputType.numberWithOptions(decimal: allowDecimal),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(allowDecimal ? r'[0-9.]' : r'[0-9]'),
        ),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Entry'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter today’s health details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            buildNumberField(
              label: 'Weight (kg)',
              controller: weightController,
              hint: 'e.g. 74.0',
              allowDecimal: true,
            ),
            const SizedBox(height: 16),
            buildNumberField(
              label: 'Water Intake (L)',
              controller: waterController,
              hint: 'e.g. 2.4',
              allowDecimal: true,
            ),
            const SizedBox(height: 16),
            buildNumberField(
              label: 'Sleep (hours)',
              controller: sleepController,
              hint: 'e.g. 7.5',
              allowDecimal: true,
            ),
            const SizedBox(height: 16),
            buildNumberField(
              label: 'Steps',
              controller: stepsController,
              hint: 'e.g. 8500',
            ),
            const SizedBox(height: 16),
            buildNumberField(
              label: 'Calories',
              controller: caloriesController,
              hint: 'e.g. 1650',
            ),
            const SizedBox(height: 16),
            buildNumberField(
              label: 'Protein (g)',
              controller: proteinController,
              hint: 'e.g. 75',
              allowDecimal: true,
            ),
            const SizedBox(height: 16),
            buildNumberField(
              label: 'Carbs (g)',
              controller: carbsController,
              hint: 'e.g. 180',
              allowDecimal: true,
            ),
            const SizedBox(height: 16),
            buildNumberField(
              label: 'Fat (g)',
              controller: fatController,
              hint: 'e.g. 55',
              allowDecimal: true,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Scan Food (mock)'),
                onPressed: () async {
                  final res = await context.push<Map<String, dynamic>>('/scanner');

                  if (!mounted) return;
                  if (res == null) return;

                  // merge returned nutrition into existing values
                  final currentCalories = int.tryParse(caloriesController.text) ?? 0;
                  final addCalories = _asNum(res['calories']).toInt();
                  caloriesController.text = (currentCalories + addCalories).toString();

                  final currentProtein = double.tryParse(proteinController.text) ?? 0.0;
                  proteinController.text =
                      (currentProtein + _asNum(res['protein']).toDouble())
                          .toStringAsFixed(1);

                  final currentCarbs = double.tryParse(carbsController.text) ?? 0.0;
                  carbsController.text =
                      (currentCarbs + _asNum(res['carbs']).toDouble())
                          .toStringAsFixed(1);

                  final currentFat = double.tryParse(fatController.text) ?? 0.0;
                  fatController.text =
                      (currentFat + _asNum(res['fat']).toDouble())
                          .toStringAsFixed(1);
                },
              ),
            ),
            const SizedBox(height: 16),
            buildNumberField(
              label: 'Exercise Minutes',
              controller: exerciseController,
              hint: 'e.g. 45',
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: selectedMood,
              decoration: InputDecoration(
                labelText: 'Mood',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Happy', child: Text('Happy')),
                DropdownMenuItem(value: 'Normal', child: Text('Normal')),
                DropdownMenuItem(value: 'Tired', child: Text('Tired')),
                DropdownMenuItem(value: 'Stressed', child: Text('Stressed')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedMood = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              minLines: 2,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: isSaving ? null : saveEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0F766E),
                ),
                child: isSaving
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : const Text(
                        'Save Daily Entry',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  num _asNum(dynamic value) => value is num ? value : num.tryParse('$value') ?? 0;
}
