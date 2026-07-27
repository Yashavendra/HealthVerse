import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FoodScannerScreen extends StatefulWidget {
  const FoodScannerScreen({super.key});

  @override
  State<FoodScannerScreen> createState() => _FoodScannerScreenState();
}

class _FoodScannerScreenState extends State<FoodScannerScreen> {

  final ImagePicker _picker = ImagePicker();

  File? selectedImage;

  bool isProcessing = false;
  String detectedFood = "";
  double calories = 0;
  double protein = 0;
  double carbs = 0;
  double fat = 0;


  Future<void> pickFromCamera() async {

    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() {

      selectedImage = File(image.path);
      

    });
    processImage();

  }

  Future<void> pickFromGallery() async {

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() {

      selectedImage = File(image.path);

    });

    processImage();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(

        backgroundColor: const Color(0xff0F766E),

        foregroundColor: Colors.white,

        title: const Text("AI Food Scanner"),

        centerTitle: true,

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(

              "Scan Your Meal",

              style: TextStyle(

                fontSize: 30,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 8),

            const Text(

              "Take a photo or upload an image.\nAI will identify the food automatically.",

              style: TextStyle(

                color: Colors.grey,

                fontSize: 15,

              ),

            ),

            const SizedBox(height: 25),

            buildImagePreview(),

            const SizedBox(height: 25),

            Row(

              children: [

                Expanded(

                  child: ElevatedButton.icon(

                    onPressed: pickFromCamera,

                    icon: const Icon(Icons.camera_alt),

                    label: const Text("Camera"),

                    style: ElevatedButton.styleFrom(

                      minimumSize: const Size.fromHeight(55),

                      backgroundColor: const Color(0xff0F766E),

                      foregroundColor: Colors.white,

                    ),

                  ),

                ),

                const SizedBox(width: 15),

                Expanded(

                  child: ElevatedButton.icon(

                    onPressed: pickFromGallery,

                    icon: const Icon(Icons.photo),

                    label: const Text("Gallery"),

                    style: ElevatedButton.styleFrom(

                      minimumSize: const Size.fromHeight(55),

                      backgroundColor: Colors.orange,

                      foregroundColor: Colors.white,

                    ),

                  ),

                ),

              ],

            ),

            const SizedBox(height: 35),

            buildAIResultCard(),

          ],

        ),

      ),

    );

  }

  Widget buildImagePreview() {

    return Container(

      width: double.infinity,

      height: 280,

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(

          color: Colors.grey.shade300,

        ),

      ),

      child: selectedImage == null

          ? Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: const [

                Icon(

                  Icons.image,

                  size: 80,

                  color: Colors.grey,

                ),

                SizedBox(height: 15),

                Text(

                  "No Image Selected",

                  style: TextStyle(

                    fontSize: 18,

                    color: Colors.grey,

                  ),

                ),

              ],

            )

          : ClipRRect(

              borderRadius: BorderRadius.circular(20),

              child: Image.file(

                selectedImage!,

                fit: BoxFit.cover,

              ),

            ),

    );

  }
  Future<void> processImage() async {
    if (selectedImage == null) return;

    setState(() {
      isProcessing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      detectedFood = "Grilled Chicken with Rice";
      calories = 620;
      protein = 42;
      carbs = 55;
      fat = 18;
      isProcessing = false;
    });
  }


  Widget buildAIResultCard() {
    return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: isProcessing
          ? const Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  "AI is analyzing your meal...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "AI Result",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                buildRow(
                  "Food",
                  detectedFood.isEmpty ? "-" : detectedFood,
                ),

                buildRow(
                  "Calories",
                  calories == 0 ? "-" : "${calories.toStringAsFixed(0)} kcal",
                ),

                buildRow(
                  "Protein",
                  protein == 0 ? "-" : "${protein.toStringAsFixed(1)} g",
                ),

                buildRow(
                  "Carbs",
                  carbs == 0 ? "-" : "${carbs.toStringAsFixed(1)} g",
                ),

                buildRow(
                  "Fat",
                  fat == 0 ? "-" : "${fat.toStringAsFixed(1)} g",
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: detectedFood.isEmpty
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Food saved successfully.",
                                ),
                              ),
                            );
                          },
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                  ),
                ),
              ],
            ),
    ),
  );}

  Widget buildRow(String title, String value) {

    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(

        children: [

          Text(

            title,

            style: const TextStyle(

              fontWeight: FontWeight.bold,

            ),

          ),

          const Spacer(),

          Text(value),

        ],

      ),

    );

  }

}