// lib/widgets/export_button.dart

import 'package:flutter/material.dart';

class ExportButton extends StatelessWidget {
  final VoidCallback onExport;

  const ExportButton({super.key, required this.onExport});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onExport,
      icon: const Icon(Icons.print),
      label: const Text('Export & Print'),
    );
  }
}