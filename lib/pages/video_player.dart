import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';

import '../utils/shortcuts.dart'; // Provides [VideoController] & [Video] etc.

class VideoPlayer extends StatefulWidget {
  final String video;
  final String referer;
  final String title;
  const VideoPlayer({
    super.key,
    required this.video,
    required this.referer,
    required this.title,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    player.open(Media(
      widget.video,
      httpHeaders: {
        "referer": widget.referer,
      },
      extras: {
        "Title": widget.title,
      },
    ));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: <Type, Action<Intent>>{
        BackIntent: CallbackAction(onInvoke: (Intent intent) {
          Navigator.of(context).pop();
          return null;
        }),
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: Flexible(
            child: Video(
              controller: controller,
              wakelock: false,
            ),
          ),
        ),
      ),
    );
  }
}
