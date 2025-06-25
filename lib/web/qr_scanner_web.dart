// lib/web/qr_scanner_web.dart

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../web_view_registry.dart';

class QrScannerWebView extends StatefulWidget {
  const QrScannerWebView({super.key});

  @override
  State<QrScannerWebView> createState() => _QrScannerWebViewState();
}

class _QrScannerWebViewState extends State<QrScannerWebView> {
  late html.DivElement _targetDiv;

  @override
  void initState() {
    super.initState();

    final String viewId = 'html5qrscanner';
    _targetDiv = html.DivElement()
      ..id = viewId
      ..style.width = '100%'
      ..style.height = '400px';

    registerWebViewFactory(viewId, (int viewId) => _targetDiv);

    Future.delayed(const Duration(milliseconds: 100), () {
      html.window.console.log("Init scanner JS");
      html.ScriptElement script = html.ScriptElement();
      script.innerHtml = """
window.html5Scanner = new Html5Qrcode("html5qrscanner");
window.html5Scanner.start(
  { facingMode: "environment" },
  {
    fps: 10,
    qrbox: 250,
    formatsToSupport: [
      Html5QrcodeSupportedFormats.EAN_13,
      Html5QrcodeSupportedFormats.CODE_128,
      Html5QrcodeSupportedFormats.UPC_A
    ]
  },
  qrCodeMessage => {
    window.html5Scanner.stop().then(() => {
      window.parent.postMessage(qrCodeMessage, "*");
    }).catch(err => {
      console.error("Stop failed:", err);
    });
  },
  errorMessage => {
    console.warn("Scan error", errorMessage);
  }
);
""";
      html.document.body?.append(script);
    });

    html.window.onMessage.listen((event) {
      final code = event.data;
      Navigator.pop(context, code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Barcode (Web)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              html.window.console.log("Stopping scanner...");
              final stopScript = html.ScriptElement();
              stopScript.innerHtml = """
                if (window.html5Scanner) {
                  window.html5Scanner.stop().then(() => {
                    console.log("Scanner stopped");
                  }).catch(err => console.error("Failed to stop scanner", err));
                }
              """;
              html.document.body?.append(stopScript);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: HtmlElementView(viewType: 'html5qrscanner'),
    );
  }
}