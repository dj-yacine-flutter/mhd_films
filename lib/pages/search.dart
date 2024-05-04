import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhd_films/core/iframe/iframe_cubit.dart';
import 'package:mhd_films/core/search/search_bloc.dart';
import 'package:mhd_films/core/video/video_cubit.dart';
import 'package:mhd_films/pages/video_player.dart';

import '../widgets/poster.dart';
import '../widgets/routly.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchTxt = TextEditingController();
  final SearchBloc _searchBloc = SearchBloc();
  final IframeCubit _iframeCubit = IframeCubit();
  final VideoCubit _videoCubit = VideoCubit();
  final FocusNode _focusNode = FocusNode();

  bool isX = false;
  double? h = 0;
  double? w = 0;

  void getLink(String name) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Get Video..."),
            content: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: BlocListener<VideoCubit, VideoState>(
                    bloc: _videoCubit,
                    listener: (context, state) async {
                      if (state is VideoLoaded) {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          Routly(
                            route: VideoPlayer(
                              video: state.link,
                              referer: state.referer,
                              title: name,
                            ),
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<VideoCubit, VideoState>(
                      bloc: _videoCubit,
                      builder: (context, state) {
                        if (state is VideoError) {
                          return const Text(
                            "ERROR :\n choose another server.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void getIframes(String name) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Get Servers"),
            content: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<IframeCubit, IframeState>(
                bloc: _iframeCubit,
                builder: (context, state) {
                  if (state is IframeLoading) {
                    return const SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is IframeLoaded) {
                    return Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children:
                          List<Widget>.generate(state.iframes.length, (index) {
                        final v = state.iframes[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: MaterialButton(
                           color: Theme.of(context).colorScheme.primary,
                            hoverColor: Theme.of(context).colorScheme.onSurface,
                            highlightColor: Theme.of(context).colorScheme.onSurface,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            onPressed: () {
                              getLink(name);
                              _videoCubit.extract(v);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Uri.parse(v).host,
                                style: const TextStyle(
                                  color: Colors.black,
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
                      "Error when getting the servers !!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _searchBloc.close();
    _iframeCubit.close();
    _searchTxt.dispose();
    _videoCubit.close();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _searchBloc,
        ),
        BlocProvider(
          create: (context) => _iframeCubit,
        ),
      ],
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                      hintText: "search by movie name",
                      labelText: "movie name",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 3,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 3,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          onPressed: () {
                            _searchTxt.clear();
                            _searchBloc.add(Clean());
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        _searchBloc.add(Search(query: query));
                        _focusNode.unfocus();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox.square(dimension: 20),
              Flexible(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      width: isX ? w : 400,
                      height: isX ? h : 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: BlocListener<SearchBloc, SearchState>(
                        listener: (context, state) {
                          if (state is SearchEmpty) {
                            setState(() {
                              w = 0;
                              h = 0;
                              isX = false;
                            });
                          } else if (state is SearchLoading) {
                            setState(() {
                              w = 100;
                              h = 100;
                              isX = true;
                            });
                          } else if (state is SearchLoaded) {
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
                          child: BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              if (state is SearchEmpty) {
                                return const Text(
                                  "Start Searching",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                );
                              } else if (state is SearchLoading) {
                                return const CircularProgressIndicator();
                              } else if (state is SearchLoaded) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15.0),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      child: Wrap(
                                          children: List<Widget>.generate(
                                              state.movies.length, (index) {
                                        final v = state.movies[index];
                                        return SizedBox(
                                          width: 200,
                                          height: 300,
                                          child: Poster(
                                            data: v,
                                            callback: () {
                                              _iframeCubit.start(v.href);
                                              getIframes(v.title);
                                            },
                                          ),
                                        );
                                      })),
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
            ],
          ),
        ),
      ),
    );
  }
}
