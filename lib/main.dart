import 'package:flutter/material.dart';
import 'package:stripe_pay/view/home.view.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  Stripe.publishableKey = 'sk_test_51Nq9HySEvcsd1ZN9rwm28ELRA7yk4G1hpzmmy0njPAJGGKCcL5au3DFhe4D44cEuJUuLvIyZEaxL8JJv1TE2EYmd001SmPSbUI';
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
