part of 'anime_search_bloc.dart';

sealed class AnimeSearchState extends Equatable {
  const AnimeSearchState();
  @override
  List<Object> get props => [];
}

final class AnimeSearchEmpty extends AnimeSearchState {}

final class AnimeSearchError extends AnimeSearchState {}

final class AnimeSearchLoading extends AnimeSearchState {}

final class AnimeSearchLoaded extends AnimeSearchState {
  final List<Anime> animes;
  const AnimeSearchLoaded({required this.animes});
  @override
  List<Object> get props => [animes];
}
