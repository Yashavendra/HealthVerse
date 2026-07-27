import 'package:flutter/material.dart';

import '../services/food_log_service.dart';

class FoodLogScreen extends StatefulWidget {
  const FoodLogScreen({super.key});

  @override
  State<FoodLogScreen> createState() => _FoodLogScreenState();
}

class _FoodLogScreenState extends State<FoodLogScreen> {
  final FoodLogService _service = FoodLogService();
  bool _loading = true;
  List<Map<String, dynamic>> _logs = [];
  Map<String, double> _aggregate = {'calories': 0, 'protein': 0, 'carbs': 0, 'fat': 0};

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    setState(() {
      _loading = true;
    });
    try {
      final logs = await _service.getLogsForDate(DateTime.now());
      final aggregate = await _service.aggregateForDate(DateTime.now());
      if (!mounted) return;
      setState(() {
        _logs = logs;
        _aggregate = aggregate;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _logs = [];
        _aggregate = {'calories': 0, 'protein': 0, 'carbs': 0, 'fat': 0};
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Log'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadLogs,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Today’s Nutrition', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          _buildSummaryRow(
                            'Calories',
                            '${_aggregate['calories']?.toStringAsFixed(0) ?? '0'} kcal',
                          ),
                          _buildSummaryRow(
                            'Protein',
                            '${_aggregate['protein']?.toStringAsFixed(1) ?? '0.0'} g',
                          ),
                          _buildSummaryRow(
                            'Carbs',
                            '${_aggregate['carbs']?.toStringAsFixed(1) ?? '0.0'} g',
                          ),
                          _buildSummaryRow(
                            'Fat',
                            '${_aggregate['fat']?.toStringAsFixed(1) ?? '0.0'} g',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _logs.isEmpty
                        ? const Center(child: Text('No food items logged today.'))
                        : ListView.separated(
                            itemCount: _logs.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final log = _logs[index];
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(log['name'] as String? ?? 'Unknown', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${log['calories']} kcal', style: const TextStyle(fontWeight: FontWeight.w600)),
                                          Text('${DateTime.fromMillisecondsSinceEpoch(log['timestamp'] as int).hour.toString().padLeft(2, '0')}:${DateTime.fromMillisecondsSinceEpoch(log['timestamp'] as int).minute.toString().padLeft(2, '0')}', style: const TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Protein: ${log['protein']}g  Carbs: ${log['carbs']}g  Fat: ${log['fat']}g', style: const TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
