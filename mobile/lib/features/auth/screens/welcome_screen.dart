
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [

              const SizedBox(height: 40),

              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xff0F766E),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 55,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "HealthVerse",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Your Personal AI Health Companion",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata, size: 35),
                  label: const Text(
                    "Continue with Google",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0F766E),
                  ),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton(
                  onPressed: () {
                    context.go('/main');
                  },
                  
                  child: const Text(
                    "Continue as Guest",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              TextButton(
                onPressed: () {
                  context.push('/login');
                },
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(
                    fontSize:16,
                    fontWeight:FontWeight.w600,
                  )
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
