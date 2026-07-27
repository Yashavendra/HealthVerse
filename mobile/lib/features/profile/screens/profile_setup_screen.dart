import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetupScreen extends StatefulWidget {
  final bool isEditing;

  const ProfileSetupScreen({super.key, this.isEditing = false});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String selectedGender = "Male";

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  Future<void> continueToDashboard() async {
  if (ageController.text.trim().isEmpty ||
      heightController.text.trim().isEmpty ||
      weightController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all fields"),
      ),
    );
    return;
  }

  final age = int.tryParse(ageController.text);
  final height = int.tryParse(heightController.text);
  final weight = double.tryParse(weightController.text);

  if (age == null || age < 10 || age > 100) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Age must be a valid number between 10 and 100"),
      ),
    );
    return;
  }

  if (height == null || height < 120 || height > 230) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Height must be between 120 cm and 230 cm"),
      ),
    );
    return;
  }

  if (weight == null || weight < 30 || weight > 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Weight must be between 30 kg and 200 kg"),
      ),
    );
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('dashboard_age', age);
  await prefs.setString('dashboard_gender', selectedGender);
  await prefs.setDouble('dashboard_height', height.toDouble());
  await prefs.setDouble('dashboard_weight', weight);

  // mark profile completed
  await prefs.setBool('dashboard_profile_completed', true);

  if (!mounted) return;

  if (widget.isEditing) {
    context.pop(true);
    return;
  }

  context.go('/focus');
}

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final age = prefs.getInt('dashboard_age');
    final gender = prefs.getString('dashboard_gender');
    final height = prefs.getDouble('dashboard_height');
    final weight = prefs.getDouble('dashboard_weight');

    if (age != null) ageController.text = age.toString();
    if (height != null) heightController.text = height.toStringAsFixed(0);
    if (weight != null) weightController.text = weight.toStringAsFixed(1);
    if (gender != null) selectedGender = gender;

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Profile Setup"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 20),

            const Text(
              "Complete Your Profile",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "This information helps us personalize your health journey.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: "Age",
                hintText: "10-100",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: selectedGender,
              decoration: InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Male",
                  child: Text("Male"),
                ),
                DropdownMenuItem(
                  value: "Female",
                  child: Text("Female"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: "Height (cm)",
                hintText: "120-230",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                hintText: "30-200",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: continueToDashboard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0F766E),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
