import 'package:flutter/material.dart';
import 'package:take_home_assessment/providers/theme_provider.dart';
import 'package:take_home_assessment/utils/setup_locator.dart';
import 'market_data_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = getIt<ThemeProvider>();
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
