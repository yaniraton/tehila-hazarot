// lib/utils/pdf_export.dart

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/product.dart';

Future<Uint8List> generateProductPdf(List<Product> products) async {
  final pdf = pw.Document();
  final fontData = await rootBundle.load("assets/fonts/Alef-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);

  final headers = ['כמות', 'שם המוצר', 'ברקוד'];
  final data = products
      .map((p) => [p.quantity.toString(), p.name, p.barcode])
      .toList();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Table.fromTextArray(
            headers: headers,
            data: data,
            cellStyle: pw.TextStyle(font: ttf, fontSize: 12),
            headerStyle: pw.TextStyle(font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.center,
            headerAlignment: pw.Alignment.center,
          ),
        );
      },
    ),
  );

  return pdf.save();
}