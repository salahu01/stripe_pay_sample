import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  String? secret;
  String? token;

  Future<void> getToken() async {
    setState(() => isLoading = true);
    try {
      final body = {
        "email": "swathirandillath0@gmail.com",
        "password": "12345678",
      };
      final res = await Dio().post(
        'https://fiveapp.dev.fegno.com/api/user/login/',
        options: Options(
          contentType: 'application/json',
        ),
        data: body,
      );
      token = res.data['token'];
      if (token != null) {
        await fetchSecret();
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text('$e')));
      log(e.toString());
      throw 'error';
    }
    setState(() => isLoading = false);
  }

  Future<void> fetchSecret() async {
    setState(() => isLoading = true);
    try {
      final body = {
        "modules_ids": [2],
        "total_price": 1000,
        "subscription_type": "WEEK"
      };
      final res = await Dio().post(
        'https://fiveapp.dev.fegno.com/api/payment/initiate-payment/',
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': 'Token $token'},
        ),
        data: body,
      );
      secret = res.data['client_secret'];
      debugPrint('secret is : $secret');
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text('$e')));
      log(e.toString());
      throw 'error';
    }
    setState(() => isLoading = false);
  }

  Future<void> pay() async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: secret,
          style: ThemeMode.dark,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            currencyCode: 'US',
            testEnv: true,
          ),
          merchantDisplayName: 'sample',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Visibility(
          visible: !isLoading,
          replacement: const CircularProgressIndicator(),
          child: Visibility(
            visible: token != null,
            replacement: ElevatedButton(
              onPressed: getToken,
              child: const Text('Login', style: TextStyle(fontSize: 40)),
            ),
            child: ElevatedButton(
              onPressed: pay,
              child: const Text('Pay', style: TextStyle(fontSize: 40)),
            ),
          ),
        ),
      ),
    );
  }
}
