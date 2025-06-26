// lib/pages/product_scanner_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:printing/printing.dart';
import '../models/product.dart';
import '../widgets/product_form.dart';
import '../widgets/product_list.dart';
import '../widgets/export_button.dart';
import '../utils/pdf_export.dart';
import '../web/qr_scanner_stub.dart'
    if (dart.library.html) '../web/qr_scanner_web.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class ProductScannerPage extends StatefulWidget {
  const ProductScannerPage({super.key});

  @override
  State<ProductScannerPage> createState() => _ProductScannerPageState();
}

class _ProductScannerPageState extends State<ProductScannerPage> {
  final List<Product> _products = [];
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  Future<void> _scanBarcode() async {
    if (kIsWeb) {
      final result = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (context) => const QrScannerWebView()),
      );
      if (result != null && result.isNotEmpty) {
        setState(() {
          _barcodeController.text = result;
        });
      }
    } else {
      var result = await BarcodeScanner.scan();
      setState(() {
        _barcodeController.text = result.rawContent;
      });
    }
  }

  void _addProduct() {
    if (_barcodeController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _quantityController.text.isEmpty) {
      return;
    }

    final product = Product(
      barcode: _barcodeController.text,
      name: _nameController.text,
      quantity: int.tryParse(_quantityController.text) ?? 0,
    );

    setState(() {
      _products.add(product);
      _barcodeController.clear();
      _nameController.clear();
      _quantityController.clear();
    });
  }

  Future<void> _printFile() async {
    final pdfBytes = await generateProductPdf(_products);
    await Printing.layoutPdf(
      onLayout: (_) async => pdfBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supermarket Scanner'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductForm(
                barcodeController: _barcodeController,
                nameController: _nameController,
                quantityController: _quantityController,
                onAddProduct: _addProduct,
                onScanBarcode: _scanBarcode,
              ),
              const Divider(height: 32),
              SizedBox(
                height: 300,
                child: ProductList(products: _products),
              ),
              const SizedBox(height: 8),
              ExportButton(onExport: _printFile),
            ],
          ),
        ),
      ),
    );
  }
}