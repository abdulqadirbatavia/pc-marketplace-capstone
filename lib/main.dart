import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers.dart';
import 'screens.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';
import 'utils.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Part Marketplace',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}