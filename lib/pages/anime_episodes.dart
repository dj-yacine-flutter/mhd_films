import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhd_films/core/anime/extractor/anime_extractor_cubit.dart';
import 'package:mhd_films/pages/video_player.dart';
import 'package:window_manager/window_manager.dart';

import '../core/video/video_cubit.dart';
import '../widgets/routly.dart';

class AnimeEpisodesPage extends StatefulWidget {
  final String title;
  final String href;

  const AnimeEpisodesPage({super.key, required this.title, required this.href});

  @override
  State<AnimeEpisodesPage> createState() => _AnimeEpisodesPageState();
}

class _AnimeEpisodesPageState extends State<AnimeEpisodesPage> {
  final AnimeExtractorCubit _extractorCubit = AnimeExtractorCubit();
  final VideoCubit _videoCubit = VideoCubit();

  String title = "";

  @override
  void initState() {
    super.initState();
    _extractorCubit.extract(widget.href);
    windowManager.setTitle(widget.title);
  }

  @override
  void dispose() {
    _extractorCubit.close();
    _videoCubit.close();
    super.dispose();
  }

  void load() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Get Videos ..."),
          content: SizedBox(
            height: 100,
            width: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void error() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Error"),
          content: Text(
            "No server found !!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _extractorCubit,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocListener(
          bloc: _videoCubit,
          listener: (context, state) {
            if (state is VideoLoading) {
              load();
            }
            if (state is VideoLoaded) {
              Navigator.of(context).pop();
              debugPrint(state.link);
              Navigator.push(
                context,
                Routly(
                  route: VideoPlayer(
                    video: state.link,
                    referer: state.referer,
                    title: title,
                    color: Colors.blue,
                  ),
                ),
              );
            }
            if (state is VideoError) {
              Navigator.of(context).pop();
              error();
            }
          },
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: BlocBuilder(
                    bloc: _extractorCubit,
                    builder: (context, state) {
                      if (state is AnimeExtractorLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is AnimeExtractorLoaded) {
                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List<Widget>.generate(state.episodes.length,
                              (index) {
                            final v = state.episodes[index];
                            return MaterialButton(
                              color: Colors.white,
                              highlightColor: Colors.black38,
                              hoverColor: Colors.black38,
                              focusColor: Colors.black38,
                              splashColor: Colors.black38,
                              padding: const EdgeInsets.all(25.0),
                              shape: const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              onPressed: () {
                                title = "${widget.title} ${v.number}";
                                _videoCubit.extract(v.iframes);
                              },
                              child: SizedBox(
                                width: 180,
                                child: Center(
                                  child: Text(
                                    v.number,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      } else {
                        return const Text(
                          "No Data Found !!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
