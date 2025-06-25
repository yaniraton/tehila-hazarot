import 'package:flutter/material.dart';
import 'pages/product_scanner_page.dart';

void main() {
  runApp(const SupermarketApp());
}

class SupermarketApp extends StatelessWidget {
  const SupermarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductScannerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}