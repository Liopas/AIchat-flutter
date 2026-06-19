import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'provider_settings_screen.dart';
import 'statistics_screen.dart';
import 'expenses_chart_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final pages = const [
    ChatScreen(),
    ProviderSettingsScreen(),
    StatisticsScreen(),
    ExpensesChartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          backgroundColor: const Color(0xFF000000), // фон панели
          selectedItemColor: const Color(0xFF4F46E5), // активная вкладка
          unselectedItemColor: const Color(0xFF9CA3AF), // неактивные вкладки
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Провайдер',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Статистика',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: 'Расходы',
            ),
          ],
        ),
    );
  }
}