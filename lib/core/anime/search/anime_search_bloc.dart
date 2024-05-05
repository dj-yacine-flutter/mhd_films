import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

import '../../../models/anime.dart';

part 'anime_search_event.dart';
part 'anime_search_state.dart';

class AnimeSearchBloc extends Bloc<AnimeSearchEvent, AnimeSearchState> {
  AnimeSearchBloc() : super(AnimeSearchEmpty()) {
    on<AnimeSimpleQuery>((event, emit) async {
      try {
        emit(
          AnimeSearchLoading(),
        );

        final headers = {
          'User-Agent':
              'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
          'Content-Type': 'application/x-www-form-urlencoded',
          'cache-control': 'max-age=0',
          'sec-ch-ua': '"Not-A.Brand";v="99", "Chromium";v="124"',
          'origin': 'https://vostfree.ws',
          'sec-fetch-site': 'same-origin',
          'sec-fetch-mode': 'navigate',
          'referer': 'https://vostfree.ws/',
          'accept-language': 'en-US,en;q=0.9',
        };

        final data = {
          'do': 'search',
          'subaction': 'search',
          'story': event.query,
          'submit': 'Submit',
        };

        final url = Uri.parse('https://vostfree.ws');

        final res = await http.post(url, headers: headers, body: data);
        final status = res.statusCode;
        if (status < 200 && status > 304) {
          throw Exception('http.post error: statusCode= $status');
        }

        List<Anime> animes = [];

        final doc = parser.parse(res.body);
        if (doc.body == null) {
          throw Exception('document is null');
        }

        final elements = doc.body!.getElementsByClassName("search-result");
        for (final v in elements) {
          String version = "";
          final versionTag = v.querySelector(".quality");
          if (versionTag != null) {
            version = versionTag.text;
          }

          String img = "";
          final imgTag = v.querySelector("img");
          if (imgTag != null) {
            imgTag.attributes.forEach((key, value) {
              if (key.toString().contains("src")) {
                img = "https://vostfree.ws$value";
              }
            });
          }

          String title = "";
          String href = "";
          final titleDiv = v.querySelector(".title");
          if (titleDiv != null) {
            final aTag = titleDiv.querySelector("a");
            if (aTag != null) {
              title = aTag.text;
              aTag.attributes.forEach((key, value) {
                if (key.toString().contains("href")) {
                  href = value;
                }
              });
            }
          }

          String season = "";
          String episodes = "";
          final seasonDiv = v.querySelector(".kp");
          if (seasonDiv != null) {
            final bTag = seasonDiv.querySelector("b");
            if (bTag != null) {
              season = bTag.text;
            }
          }

          final episodeDiv = v.querySelector(".year");
          if (episodeDiv != null) {
            final bTag = episodeDiv.querySelector("b");
            if (bTag != null) {
              episodes = bTag.text;
            }
          }

          String year = "";
          final lis = v.getElementsByTagName("li");
          if (lis.isNotEmpty) {
            final aTag = lis.last.querySelector("a");
            if (aTag != null) {
              year = aTag.text;
            }
          }

          animes.add(
            Anime(
                title: title,
                img: img,
                href: href,
                season: season,
                episodes: episodes,
                version: version,
                year: year),
          );
        }

        if (animes.isEmpty) {
          throw Exception('no anime found');
        }

        emit(
          AnimeSearchLoaded(animes: animes),
        );
      } catch (e) {
        emit(
          AnimeSearchError(),
        );
      }
    });
    on<AnimeCleanQuery>((event, emit) async {
      emit(
        AnimeSearchEmpty(),
      );
    });
  }
}
