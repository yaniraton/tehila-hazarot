// lib/web_view_registry_web.dart

import 'dart:ui_web' as ui;

void registerWebViewFactory(String viewType, dynamic Function(int) viewFactory) {
  ui.platformViewRegistry.registerViewFactory(viewType, viewFactory);
}