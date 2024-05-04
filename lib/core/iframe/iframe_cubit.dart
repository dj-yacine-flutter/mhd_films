import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

part 'iframe_state.dart';

class IframeCubit extends Cubit<IframeState> {
  IframeCubit() : super(IframeLoading());

  Future<void> start(String href) async {
    emit(IframeLoading());
    try {
      final headers = {
        'User-Agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        'sec-ch-ua': '"Chromium";v="123", "Not:A-Brand";v="8"',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-mode': 'navigate',
        'sec-fetch-dest': 'document',
        'referer': 'https://www.cpasmieux.is/',
        'accept-language': 'en-US,en;q=0.9',
      };

      final url = Uri.parse(href);

      final res = await http.get(url, headers: headers);
      final status = res.statusCode;
      if (status != 200) {
        throw Exception('http.get error: statusCode= $status');
      }

      final doc = parser.parse(res.body);
      final list = doc.querySelector(".player-list");
      if (list == null) {
        emit(IframeError());
        return;
      }

      final elements = list.getElementsByClassName("lien");
      final List<String> iframes = [];
      for (final v in elements) {
        v.attributes.forEach((key, value) {
          if (key.toString().contains("data-url")) {
            if (value.contains("voe.") || value.contains("uqload.")) {
              iframes.add(value);
            }
          }
        });
      }

      emit(IframeLoaded(iframes: iframes));
    } catch (e) {
      print(e);
      emit(IframeError());
    }
  }
}
