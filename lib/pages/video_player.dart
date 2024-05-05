import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';
import 'package:window_manager/window_manager.dart';

class VideoPlayer extends StatefulWidget {
  final String video;
  final String referer;
  final String title;
  final Color color;
  const VideoPlayer({
    super.key,
    required this.video,
    required this.referer,
    required this.title,
    required this.color,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final player = Player();
  late final controller = VideoController(player);
  bool isFull = false;

  @override
  void initState() {
    super.initState();
    _updateTitle();
    player.open(Media(
      widget.video,
      httpHeaders: {
        "referer": widget.referer,
      },
      extras: {
        "title": widget.title,
      },
    ));
    player.stream.error.listen((error) => debugPrint(error));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void _updateTitle() async {
    windowManager.setTitle(widget.title);
  }

  void _toggleFull() async {
    setState(() {
      isFull = !isFull;
    });
    await windowManager.setFullScreen(isFull);
  }

  @override
  Widget build(BuildContext context) {
    return // Wrap [Video] widget with [MaterialVideoControlsTheme].
        GestureDetector(
      onDoubleTap: _toggleFull,
      child: MaterialDesktopVideoControlsTheme(
        normal: MaterialDesktopVideoControlsThemeData(
            topButtonBar: topBar(context),
            toggleFullscreenOnDoublePress: false,
            seekBarPositionColor: widget.color,
            seekBarColor: widget.color.withOpacity(0.2),
            seekBarThumbColor: widget.color,
            bottomButtonBar: [
              const MaterialDesktopPlayOrPauseButton(),
              const MaterialDesktopVolumeButton(),
              const MaterialDesktopPositionIndicator(),
            ]),
        fullscreen: MaterialDesktopVideoControlsThemeData(
            topButtonBar: topBar(context),
            toggleFullscreenOnDoublePress: false,
            seekBarPositionColor: widget.color,
            seekBarColor: widget.color.withOpacity(0.2),
            seekBarThumbColor: widget.color,
            bottomButtonBar: [
              const MaterialDesktopPlayOrPauseButton(),
              const MaterialDesktopVolumeButton(),
              const MaterialDesktopPositionIndicator(),
            ]),
        child: Video(
          controller: controller,
          filterQuality: FilterQuality.high,
          wakelock: true,
        ),
      ),
    );
  }

  List<Widget> topBar(BuildContext context) {
    return [
      MaterialDesktopCustomButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const Spacer(),
      MaterialDesktopCustomButton(
        icon: const Icon(Icons.fit_screen_rounded),
        onPressed: _toggleFull,
      ),
    ];
  }
}
