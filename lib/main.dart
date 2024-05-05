import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhd_films/pages/home.dart';
import 'package:media_kit/media_kit.dart' show MediaKit;
import 'package:mhd_films/utils/shortcuts.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: false,
    title: 'MHD Films',
    minimumSize: Size(500, 500),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(
    MaterialApp(
      title: 'MHD Films',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey.shade900,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: Shortcuts(shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.escape): const BackIntent(),
      }, child: const HomePage()),
    ),
  );
}
