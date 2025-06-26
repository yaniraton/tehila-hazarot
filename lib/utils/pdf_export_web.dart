// lib/utils/pdf_export_web.dart
import 'dart:html' as html;
import 'dart:typed_data';

void exportPdfToNewTab(Uint8List pdfBytes) {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  final isSafari = userAgent.contains('safari') && !userAgent.contains('chrome');

  if (isSafari) {
    final newWindow = html.window.open('', '_blank');
    final blob = html.Blob([pdfBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    newWindow!.location.href = url;
  }
}