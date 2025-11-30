import 'package:flupee/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flupee Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:  ColorScheme.fromSeed(
          seedColor: const Color(0xFF006666),
          primary: const Color(0xFF006666),
          // Um tom secundário para contraste
          secondary: const Color(0xFFFF9F1C), 
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen()
    );
  }
}
