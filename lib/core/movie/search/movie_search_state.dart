part of 'movie_search_bloc.dart';

sealed class MovieSearchState extends Equatable {
  const MovieSearchState();
  @override
  List<Object> get props => [];
}

final class MovieSearchEmpty extends MovieSearchState {}

final class MovieSearchError extends MovieSearchState {}

final class MovieSearchLoading extends MovieSearchState {}

final class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;
  const MovieSearchLoaded({required this.movies});
  @override
  List<Object> get props => [movies];
}
