import 'package:flutter/material.dart';

import '../../dashboard/screens/dashboard_screen.dart';
import '../../journal/screens/journal_screen.dart';
import '../../ai/screens/ai_screen.dart';
import '../../reports/screens/reports_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int currentIndex = 0;

  final List<Widget> pages = const [

    DashboardScreen(),

    JournalScreen(),

    AIScreen(),

    ReportsScreen(),

    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(

        index: currentIndex,

        children: pages,

      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xff0F766E),

        unselectedItemColor: Colors.grey,

        selectedFontSize: 12,

        unselectedFontSize: 12,

        onTap: (index) {

          setState(() {

            currentIndex = index;

          });

        },

        items: const [

          BottomNavigationBarItem(

            icon: Icon(Icons.home),

            label: "Home",

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.book),

            label: "Journal",

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.smart_toy),

            label: "AI",

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.bar_chart),

            label: "Reports",

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.person),

            label: "Profile",

          ),

        ],

      ),

    );
  }
}