import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhd_films/core/anime/extractor/anime_extractor_cubit.dart';
import 'package:mhd_films/pages/video_player.dart';

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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: BlocListener(
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder(
                bloc: _extractorCubit,
                builder: (context, state) {
                  if (state is AnimeExtractorLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is AnimeExtractorLoaded) {
                    return Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children:
                          List<Widget>.generate(state.episodes.length, (index) {
                        final v = state.episodes[index];
                        return InkWell(
                          onTap: () {
                            title = v.number;
                            _videoCubit.extract(v.iframes);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                v.number,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
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
    );
  }
}
