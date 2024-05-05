part of 'movie_search_bloc.dart';

sealed class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();
}

class MovieSimpleQuery extends MovieSearchEvent {
  final String query;
  const MovieSimpleQuery({required this.query});
  @override
  List<Object> get props => [query];
}

class MovieCleanQuery extends MovieSearchEvent {
  @override
  List<Object> get props => [];
}