// lib/widgets/product_form.dart

import 'package:flutter/material.dart';

class ProductForm extends StatelessWidget {
  final TextEditingController barcodeController;
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final VoidCallback onAddProduct;
  final VoidCallback onScanBarcode;

  const ProductForm({
    super.key,
    required this.barcodeController,
    required this.nameController,
    required this.quantityController,
    required this.onAddProduct,
    required this.onScanBarcode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: barcodeController,
                decoration: const InputDecoration(labelText: 'Barcode'),
              ),
            ),
            IconButton(
              onPressed: onScanBarcode,
              icon: const Icon(Icons.qr_code_scanner),
            )
          ],
        ),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Product Name'),
        ),
        TextField(
          controller: quantityController,
          decoration: const InputDecoration(labelText: 'Quantity'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: onAddProduct,
          child: const Text('Add Product'),
        ),
      ],
    );
  }
}