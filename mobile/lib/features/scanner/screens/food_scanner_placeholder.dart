import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/nutrition_service.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import '../services/openai_client.dart';
import '../services/food_log_service.dart';

class FoodScannerPlaceholder extends StatefulWidget {
  const FoodScannerPlaceholder({super.key});

  @override
  State<FoodScannerPlaceholder> createState() => _FoodScannerPlaceholderState();
}

class _FoodScannerPlaceholderState extends State<FoodScannerPlaceholder> {
  final NutritionService _nutrition = NutritionService();
  final OpenAIClient _client = OpenAIClient();
  String query = '';
  Map<String, dynamic>? result;
  bool _loading = false;

  void _runMockScan(String text) {
    final r = _nutrition.lookupFood(text);
    setState(() {
      query = text;
      result = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Scanner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Scan or type a food item',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Pick Photo'),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final xfile = await picker.pickImage(source: ImageSource.camera);
                      if (xfile == null) return;

                      setState(() => _loading = true);
                      final file = File(xfile.path);
                      final res = await _client.scanImage(file);
                      if (!mounted) return;
                      setState(() {
                        result = res;
                        _loading = false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Pick From Gallery'),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final xfile = await picker.pickImage(source: ImageSource.gallery);
                      if (xfile == null) return;

                      setState(() => _loading = true);
                      final file = File(xfile.path);
                      final res = await _client.scanImage(file);
                      if (!mounted) return;
                      setState(() {
                        result = res;
                        _loading = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_loading) const LinearProgressIndicator(),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter food name (e.g. apple, banana, orange juice)',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => query = v,
              onSubmitted: _runMockScan,
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              children: _nutrition.sampleFoods
                  .map((s) => ActionChip(
                        label: Text(s),
                        onPressed: () => _runMockScan(s),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 18),

            if (result == null)
              const Expanded(
                child: Center(
                  child: Text('No scan result yet. Type or pick a food.'),
                ),
              )
            else
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result!['name'] ?? 'Unknown',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        _buildNutritionRow('Calories', '${result!['calories']} kcal'),
                        _buildNutritionRow('Protein', '${result!['protein']} g'),
                        _buildNutritionRow('Carbs', '${result!['carbs']} g'),
                        _buildNutritionRow('Fat', '${result!['fat']} g'),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    result = null;
                                    query = '';
                                  });
                                },
                                child: const Text('Scan Again'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // save to local food log as well
                                  final currentContext = context;
                                  try {
                                    final service = FoodLogService();
                                    final nutrition = result!;
                                    await service.insertLog({
                                      'name': nutrition['name']?.toString() ?? 'Unknown',
                                      'calories': _asNum(nutrition['calories']).toInt(),
                                      'protein': _asNum(nutrition['protein']).toDouble(),
                                      'carbs': _asNum(nutrition['carbs']).toDouble(),
                                      'fat': _asNum(nutrition['fat']).toDouble(),
                                      'imagePath': null,
                                      'timestamp': DateTime.now().millisecondsSinceEpoch,
                                    });
                                  } catch (e) {
                                    // ignore
                                  }
                                  if (!currentContext.mounted) return;
                                  currentContext.pop(result);
                                },
                                child: const Text('Add To Entry'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  num _asNum(dynamic value) => value is num ? value : num.tryParse('$value') ?? 0;
}

