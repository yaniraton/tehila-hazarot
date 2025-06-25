// lib/models/product.dart

class Product {
  final String barcode;
  final String name;
  final int quantity;

  Product({
    required this.barcode,
    required this.name,
    required this.quantity,
  });
}