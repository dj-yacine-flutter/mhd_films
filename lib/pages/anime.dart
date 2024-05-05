import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhd_films/core/anime/search/anime_search_bloc.dart';
import 'package:mhd_films/pages/anime_episodes.dart';
import 'package:mhd_films/widgets/routly.dart';

import '../widgets/anime_poster.dart';

class AnimeSearch extends StatefulWidget {
  const AnimeSearch({super.key});

  @override
  State<AnimeSearch> createState() => _AnimeSearchState();
}

class _AnimeSearchState extends State<AnimeSearch> {
  final TextEditingController _searchTxt = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final AnimeSearchBloc _searchBloc = AnimeSearchBloc();

  bool isX = false;
  double? h = 0;
  double? w = 0;

  @override
  void dispose() {
    _searchTxt.dispose();
    _focusNode.dispose();
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _searchBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
        appBar: AppBar(
          title: const Text(
            "Animes",
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
                      Colors.blue.withOpacity(0.5),
                    ],
                    stops: const [0.1, 1.0],
                  ).createShader(bounds);
                },
                child: Image.asset(
                  "assets/anime-wallpaper.webp",
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
                          hintText: "search by anime name",
                          labelText: "Anime name",
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
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blue.withOpacity(0.5),
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
                            _searchBloc.add(AnimeSimpleQuery(query: query));
                            _focusNode.unfocus();
                          } else {
                            _searchBloc.add(AnimeCleanQuery());
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
                            if (state is AnimeSearchEmpty) {
                              setState(() {
                                w = 0;
                                h = 0;
                                isX = false;
                              });
                            } else if (state is AnimeSearchLoading) {
                              setState(() {
                                w = 100;
                                h = 100;
                                isX = true;
                              });
                            } else if (state is AnimeSearchLoaded) {
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
                          child: Center(
                            child: BlocBuilder(
                              bloc: _searchBloc,
                              builder: (context, state) {
                                if (state is AnimeSearchEmpty) {
                                  return const Text(
                                    "Start searching",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  );
                                } else if (state is AnimeSearchLoading) {
                                  return const CircularProgressIndicator();
                                } else if (state is AnimeSearchLoaded) {
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
                                                state.animes.length, (index) {
                                              final v = state.animes[index];
                                              return SizedBox(
                                                width: 472,
                                                height: 350,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      Routly(
                                                        route:
                                                            AnimeEpisodesPage(
                                                          title:
                                                              "${v.title} - ${v.version}- ${v.year}",
                                                          href: v.href,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: AnimePoster(
                                                    anime: v,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
