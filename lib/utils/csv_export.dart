// lib/utils/csv_export.dart

import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';

Future<String> generateCsv(List<Product> products) async {
  final rows = <List<String>>[
    ['Barcode', 'Name', 'Quantity'],
    ...products.map((p) => [p.barcode, p.name, p.quantity.toString()])
  ];

  return const ListToCsvConverter().convert(rows);
}

Future<String> saveCsvToFile(String csvContent, {String fileName = 'products.csv'}) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$fileName');
  await file.writeAsString(csvContent);
  return file.path;
}