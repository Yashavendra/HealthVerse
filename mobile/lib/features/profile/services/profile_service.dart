import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  Future<void> saveProfile({
    required String name,
    required int age,
    required String gender,
    required double height,
    required double weight,
    required String activity,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", name);
    await prefs.setInt("age", age);
    await prefs.setString("gender", gender);
    await prefs.setDouble("height", height);
    await prefs.setDouble("weight", weight);
    await prefs.setString("activity", activity);
  }

  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("name") ?? "";
  }
}