import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

import '../../../models/anime.dart';

part 'anime_extractor_state.dart';

class AnimeExtractorCubit extends Cubit<AnimeExtractorState> {
  AnimeExtractorCubit() : super(AnimeExtractorLoading());

  Future<void> extract(String href) async {
    try {
      emit(
        AnimeExtractorLoading(),
      );

      final headers = {
        'User-Agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        'cache-control': 'max-age=0',
        'sec-ch-ua': '"Not-A.Brand";v="99", "Chromium";v="124"',
        'origin': 'https://vostfree.ws',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-mode': 'navigate',
        'referer': 'https://vostfree.ws/',
        'accept-language': 'en-US,en;q=0.9',
      };

      final url = Uri.parse(href);

      final res = await http.post(url, headers: headers);
      final status = res.statusCode;
      if (status < 200 && status > 304) {
        throw Exception('http.post error: statusCode= $status');
      }

      final doc = parser.parse(res.body);
      if (doc.body == null) {
        throw Exception('document is null');
      }

      final List<AnimeEpisode> episodes = [];

      final select = doc.querySelector("select.new_player_selector");
      if (select != null) {
        final options = select.getElementsByTagName("option");
        for (final v in options) {
          String num = "";
          num = v.text;

          if (v.attributes.isEmpty) {
            continue;
          }
          String id = "";
          v.attributes.forEach((key, value) {
            if (key == "value") {
              id = value;
              return;
            }
          });

          final btm = doc.querySelector("div.new_player_bottom");
          if (btm != null) {
            final divs = btm.getElementsByTagName("div");
            final Map<String, String> srv = {};
            for (final x in divs) {
              if (x.id == id) {
                final players = x.getElementsByTagName("div");
                for (final y in players) {
                  srv[y.id] = y.text;
                }

                final List<String> iframes = [];
                srv.forEach((key, value) {
                  final server = doc
                      .querySelector("div#content_${key.replaceAll(" ", "")}");
                  if (server == null || server.text.isEmpty) {
                    return;
                  }

                  final code = value.toLowerCase().replaceAll(" ", "");
                  if (code.isEmpty) {
                    return;
                  }

                  if (code == "sibnet") {
                    final name =
                        server.text.replaceAll(" ", "").replaceAll("\n", "");
                    iframes
                        .add("https://video.sibnet.ru/shell.php?videoid=$name");
                  } else if (code == "uqload") {
                    final name =
                        server.text.replaceAll(" ", "").replaceAll("\n", "");
                    iframes.add("https://uqload.io/embed-$name.html");
                  }
                });

                episodes.add(AnimeEpisode(number: num, iframes: iframes));
                break;
              }
            }
          }
        }
      }

      emit(
        AnimeExtractorLoaded(episodes: episodes),
      );
    } catch (e) {
      print(e);
      emit(
        AnimeExtractorError(),
      );
    }
  }
}
