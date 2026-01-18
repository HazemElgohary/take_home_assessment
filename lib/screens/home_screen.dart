import 'package:flutter/material.dart';
import 'package:take_home_assessment/providers/theme_provider.dart';
import 'package:take_home_assessment/utils/setup_locator.dart';
import 'market_data_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final themeProvider = getIt<ThemeProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PulseNow'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.dark_mode
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: const MarketDataScreen(),
    );
  }
}
