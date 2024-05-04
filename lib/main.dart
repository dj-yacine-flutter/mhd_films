import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhd_films/pages/search.dart';
import 'package:media_kit/media_kit.dart' show MediaKit;
import 'package:mhd_films/utils/shortcuts.dart'; // Provides [Player], [Media], [Playlist] etc.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'MHD Films',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: Shortcuts(shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.escape): const BackIntent(),
      }, child: const SearchPage()),
    ),
  );
}
