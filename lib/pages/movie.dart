import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mhd_films/core/movie/extractor/movie_extractor_cubit.dart';
import 'package:mhd_films/core/video/video_cubit.dart';
import 'package:mhd_films/pages/video_player.dart';
import 'package:window_manager/window_manager.dart';

import '../core/movie/search/movie_search_bloc.dart';
import '../widgets/movie_poster.dart';
import '../widgets/routly.dart';

class MovieSearch extends StatefulWidget {
  const MovieSearch({super.key});

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final TextEditingController _searchTxt = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final MovieSearchBloc _searchBloc = MovieSearchBloc();
  final MovieExtractorCubit _extractorCubit = MovieExtractorCubit();
  final VideoCubit _videoCubit = VideoCubit();

  String title = "";
  bool isX = false;
  double? h = 0;
  double? w = 0;

  @override
  void initState() {
    super.initState();
    windowManager.setTitle("Movies");
  }

  @override
  void dispose() {
    _searchTxt.dispose();
    _focusNode.dispose();
    _searchBloc.close();
    _extractorCubit.close();
    _videoCubit.close();
    super.dispose();
  }

  void load(String state) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Get $state ..."),
          content: const SizedBox(
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _searchBloc,
        ),
        BlocProvider(
          create: (_) => _extractorCubit,
        ),
        BlocProvider(
          create: (_) => _videoCubit,
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.red.shade900,
        appBar: AppBar(
          title: const Text(
            "Movies",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            LayoutBuilder(builder: (context, constraint) {
              return ShaderMask(
                blendMode: BlendMode.srcOver,
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    center: Alignment.center,
                    radius: 1.5,
                    colors: [
                      Colors.transparent,
                      Colors.red.withOpacity(0.5),
                    ],
                    stops: const [0.1, 1.0],
                  ).createShader(bounds);
                },
                child: Image.asset(
                  "assets/movie-wallpaper.webp",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                  height: constraint.maxHeight,
                  width: constraint.maxWidth,
                ),
              );
            }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _searchTxt,
                        focusNode: _focusNode,
                        textInputAction: TextInputAction.unspecified,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        autocorrect: false,
                        scribbleEnabled: false,
                        enableInteractiveSelection: true,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          hintText: "search by Movie name",
                          labelText: "Movie name",
                          border: const OutlineInputBorder(),
                          labelStyle: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 20,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 3,
                              color: Colors.red,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.red.withOpacity(0.5),
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              onPressed: () {
                                _searchTxt.clear();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                        onSubmitted: (query) {
                          if (query.isNotEmpty) {
                            _searchBloc.add(MovieSimpleQuery(query: query));
                            _focusNode.unfocus();
                          } else {
                            _searchBloc.add(MovieCleanQuery());
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox.square(dimension: 20),
                  Flexible(
                    child: Container(
                      width: isX ? w : 400,
                      height: isX ? h : 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.10,
                            spreadRadius: 2.0,
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ],
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                        child: BlocListener(
                          bloc: _searchBloc,
                          listener: (context, state) {
                            if (state is MovieSearchEmpty) {
                              setState(() {
                                w = 0;
                                h = 0;
                                isX = false;
                              });
                            } else if (state is MovieSearchLoading) {
                              setState(() {
                                w = 100;
                                h = 100;
                                isX = true;
                              });
                            } else if (state is MovieSearchLoaded) {
                              setState(() {
                                w = MediaQuery.of(context).size.width;
                                h = MediaQuery.of(context).size.height;
                                isX = true;
                              });
                            } else {
                              setState(() {
                                w = 300;
                                h = 100;
                                isX = true;
                              });
                            }
                          },
                          child: BlocListener(
                            bloc: _extractorCubit,
                            listener: (context, state) {
                              if (state is MovieExtractorLoading) {
                                load("Servers");
                              }
                              if (state is MovieExtractorLoaded) {
                                Navigator.of(context).pop();
                                _videoCubit.extract(state.iframes);
                              }
                              if (state is MovieExtractorError) {
                                Navigator.of(context).pop();
                                error();
                              }
                            },
                            child: BlocListener(
                              bloc: _videoCubit,
                              listener: (context, state) {
                                if (state is VideoLoading) {
                                  load("Videos");
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
                                        color: Colors.red,
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
                                child: BlocBuilder(
                                  bloc: _searchBloc,
                                  builder: (context, state) {
                                    if (state is MovieSearchEmpty) {
                                      return const Text(
                                        "Start searching",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      );
                                    } else if (state is MovieSearchLoading) {
                                      return const CircularProgressIndicator();
                                    } else if (state is MovieSearchLoaded) {
                                      return SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: Wrap(
                                                spacing: 5,
                                                runSpacing: 5,
                                                children: List<Widget>.generate(
                                                    state.movies.length,
                                                    (index) {
                                                  final v = state.movies[index];
                                                  return SizedBox(
                                                    width: 200,
                                                    height: 300,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        title = v.title;
                                                        await _extractorCubit
                                                            .extract(v.href);
                                                      },
                                                      child: MoviePoster(
                                                        movie: v,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        "Not Found !!",
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
