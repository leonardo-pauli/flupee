import 'package:flupee/domain/entities/product.dart';
import 'package:flupee/presentation/screens/home_screen.dart';
import 'package:flupee/presentation/screens/product_detail_screen.dart';
import 'package:flupee/presentation/widgets/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MainApp()));
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BaseLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/product',
          builder: (context, state) {
            final product = state.extra as Product;
            return ProductDetailScreen(product: product);
          },
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: _router,
    );
  }
}
