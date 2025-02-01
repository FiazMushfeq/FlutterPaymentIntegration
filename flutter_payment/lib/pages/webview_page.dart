import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.title});

  final String title;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          if (url.contains('success')) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Payment successful!'),
            ));
          } else if (url.contains('cancel')) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Payment canceled!'),
            ));
          }
        },
      ))
      ..loadRequest(Uri.parse(''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter WebView for Stripe and PayPal'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}