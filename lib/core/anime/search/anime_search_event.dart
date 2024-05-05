part of 'anime_search_bloc.dart';

sealed class AnimeSearchEvent extends Equatable {
  const AnimeSearchEvent();

}

class AnimeSimpleQuery extends AnimeSearchEvent {
  final String query;
  const AnimeSimpleQuery({required this.query});
  @override
  List<Object> get props => [query];
}

class AnimeCleanQuery extends AnimeSearchEvent {
  @override
  List<Object> get props => [];
}