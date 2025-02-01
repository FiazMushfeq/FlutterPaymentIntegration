import 'package:flutter/material.dart';
import 'package:flutter_payment/pages/webview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebView for Stripe and PayPal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WebViewPage(title: 'Flutter WebView for Stripe and PayPal'),
    );
  }
}