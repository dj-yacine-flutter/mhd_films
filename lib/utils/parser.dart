String parseIMG(String v) {
  RegExp regex = RegExp(r'url\((.*?)\)');
  Match match = regex.firstMatch(v) as Match;
  if (match.group(1) != null) {
    return match.group(1)!;
  }

  return "";
}

String parseYear(String v) {
  RegExp regex = RegExp(r'\d{4}');
  Match match = regex.firstMatch(v) as Match;
  if (match.group(0) != null) {
    return match.group(0)!;
  }

  return "";
}

