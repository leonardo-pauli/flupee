import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;

  const BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: TextButton(
          onPressed: () {
            context.go('/');
          },
          child: const Text(
            'Flupee',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF006666),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Badge(
              label: Text('0'),
              child: Icon(Icons.shopping_cart),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            iconSize: 24,
            tooltip: 'Carrinho',
          ),
          SizedBox(width: 16),
        ],
      ),
      body: child,
    );
  }
}
