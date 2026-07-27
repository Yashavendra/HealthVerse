import 'package:go_router/go_router.dart';

import '../features/splash/screens/splash_screen.dart';
import '../features/auth/screens/welcome_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/profile/screens/profile_setup_screen.dart';
import '../features/profile/screens/health_focus_screen.dart';
import '../features/navigation/screens/main_navigation_screen.dart';
import '../features/dashboard/screens/daily_entry_screen.dart';
import '../features/scanner/screens/food_log_screen.dart';
import '../features/scanner/screens/food_scanner_placeholder.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileSetupScreen(isEditing: true),
    ),
    GoRoute(
      path: '/profile-setup',
      builder: (context, state) => const ProfileSetupScreen(),
    ),
    GoRoute(
      path: '/focus',
      builder: (context, state) => const HealthFocusScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: '/daily-entry',
      builder: (context, state) => const DailyEntryScreen(),
    ),
    GoRoute(
      path: '/scanner',
      builder: (context, state) => const FoodScannerPlaceholder(),
    ),
    GoRoute(
      path: '/food-log',
      builder: (context, state) => const FoodLogScreen(),
    ),
  ],
);
