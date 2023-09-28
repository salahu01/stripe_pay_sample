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

  @override
  void initState() {
    fetchSecret();
    super.initState();
  }

  Future<void> fetchSecret() async {
    setState(() {
      isLoading = true;
    });
    try {
      const token = 'EkdYlFJZjHaJGe1P1Umbi5ksT9ToKmcpL9UzcOMv';
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
    setState(() {
      isLoading = false;
    });
  }

  Future<void> pay() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Visibility(
          visible: !isLoading,
          replacement: const CircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: () async {
              const gPay = PaymentSheetGooglePay(
                merchantCountryCode: 'US',
                currencyCode: 'US',
                testEnv: true,
              );
              try {
                await Stripe.instance.initPaymentSheet(
                  paymentSheetParameters: SetupPaymentSheetParameters(
                    paymentIntentClientSecret: secret,
                    style: ThemeMode.dark,
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
            },
            child: const Text(
              'Pay',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }
}
