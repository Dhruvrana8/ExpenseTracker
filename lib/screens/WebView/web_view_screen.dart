import 'package:dhruv_expense_tracker/screens/Home/strings.dart';
import 'package:dhruv_expense_tracker/screens/WebView/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  const WebViewScreen({super.key, required this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final String selectedUrl;
  late WebViewController controller;
  @override
  void initState() {
    super.initState();

    switch (widget.title) {
      case Strings.expenses:
        selectedUrl = dotenv.get(Strings.expenses, fallback: URLS.google);
        break;
      case Strings.income:
        selectedUrl = dotenv.get(Strings.income, fallback: URLS.google);
        break;
      default:
        selectedUrl = URLS.google;
    }

    if (!Uri.tryParse(selectedUrl)!.hasAbsolutePath ?? true) {
      debugPrint('Invalid URL: $selectedUrl');
      throw Exception('Invalid URL in .env or fallback.');
    }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(selectedUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
