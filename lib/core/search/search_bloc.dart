import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

import '../../models/movie.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchEmpty()) {
    on<Clean>((event, emit) {
      emit(SearchEmpty());
    });
    on<Search>((event, emit) async {
      emit(SearchLoading());
      try {
        final headers = {
          'User-Agent':
              'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
          'sec-ch-ua': '"Chromium";v="123", "Not:A-Brand";v="8"',
          'accept-language': 'en-US,en;q=0.9',
        };

        final url = Uri.parse(
            'https://www.cpasmieux.is/search/${Uri.encodeFull(event.query)}');

        final res = await http.post(url, headers: headers);
        final status = res.statusCode;
        if (status < 200  && status > 400) {
          throw Exception('http.post error: statusCode= $status');
        }
        List<Movie> movies = [];

        final doc = parser.parse(res.body);
        final elements = doc.body?.getElementsByClassName("movie-item2");
        for (final v in elements!) {
          final titleDiv = v.querySelector(".mi2-title");
          final title = titleDiv?.text ?? "";

          String img = "";
          final imgDiv = v.querySelector(".mi2-img");
          imgDiv?.children.forEach((element) {
            if (element.localName!.contains("img")) {
              element.attributes.forEach((key, value) {
                if (key.toString().contains("src")) {
                  img = "https://www.cpasmieux.is/$value";
                }
              });
            }
          });

          final verDiv = v.querySelector(".mi2-version");
          final ver = verDiv?.text ?? "";

          String href = "";
          final a = v.querySelector(".mi2-in-link");
          a?.attributes.forEach((key, value) {
            if (key.toString().contains("href")) {
              href = "https://www.cpasmieux.is/$value";
            }
          });
          movies.add(Movie(title: title, img: img, href: href, version: ver));
        }
        if (movies.isEmpty) {
          emit(SearchError());
        }else {
          emit(SearchLoaded(movies: movies));
        }
      } catch (e) {
        print(e);
        emit(SearchError());
      }
    });
  }
}
