import 'dart:core';
import 'package:http/http.dart' as http;

Future<String> extractUrl(String url) async {
  late final RegExp pattern;
  String link = "not-found";

  try {
    if (url.contains("voe")) {
      pattern = RegExp(r"'hls':\s*'([^']+)'");
    } else if (url.contains("uqload")) {
      pattern = RegExp(r'sources:[\s*[\r\n]*"([^"]+)"');
    } else {
      return link;
    }

    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode != 200) {
      return link;
    }

    final match = pattern.firstMatch(resp.body);
    if (match != null) {
      if (match.group(1) != null) {
        link = match.group(1) ?? "not-found";
      }
    }

    return link;
  } catch (e) {
    return "not-found";
  }
}
