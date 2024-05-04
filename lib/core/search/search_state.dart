part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

final class SearchEmpty extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<Movie> movies;

  const SearchLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class SearchError extends SearchState {}
