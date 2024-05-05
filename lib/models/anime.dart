
class Anime {
  String title;
  String img;
  String href;
  String season;
  String episodes;
  String version;
  String year;
  Anime({
    required this.title,
    required this.img,
    required this.href,
    required this.season,
    required this.episodes,
    required this.version,
    required this.year,
  });
}

class AnimeEpisode {
  String number;
  List<String> iframes;
  AnimeEpisode({
    required this.number,
    required this.iframes,
});
}