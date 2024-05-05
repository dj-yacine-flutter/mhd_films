import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhd_films/pages/home.dart';
import 'package:media_kit/media_kit.dart' show MediaKit;
import 'package:mhd_films/utils/shortcuts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'MHD Films',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
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
