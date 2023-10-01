import 'package:flutter/material.dart';
import 'package:stripe_pay/view/home.view.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  Stripe.publishableKey = 'pk_test_51Nq9HySEvcsd1ZN9tlnH5TU5DOx5QXED2A8FwbXTbDiiWOyuFVLNloGv2lvbj5MSgVu0k3N9jcWkdLoMceA57twK00rg79SGcr';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
