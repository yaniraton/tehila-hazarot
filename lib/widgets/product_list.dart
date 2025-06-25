// lib/widgets/product_list.dart

import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final p = products[index];
        return ListTile(
          title: Text(p.name),
          subtitle: Text('Barcode: ${p.barcode} | Qty: ${p.quantity}'),
        );
      },
    );
  }
}