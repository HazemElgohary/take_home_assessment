import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_home_assessment/providers/theme_provider.dart';
import 'package:take_home_assessment/utils/setup_locator.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => getIt<ThemeProvider>(),
      child: const PulseNowApp(),
    ),
  );
}

class PulseNowApp extends StatelessWidget {
  const PulseNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'PulseNow',
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(primaryColor: Colors.blue),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(primaryColor: Colors.teal),
      themeMode: themeProvider.themeMode,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
