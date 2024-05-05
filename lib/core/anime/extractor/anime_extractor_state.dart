part of 'anime_extractor_cubit.dart';

sealed class AnimeExtractorState extends Equatable {
  const AnimeExtractorState();
  @override
  List<Object> get props => [];
}

final class AnimeExtractorLoading extends AnimeExtractorState {}

final class AnimeExtractorLoaded extends AnimeExtractorState {
  final List<AnimeEpisode> episodes;
  const AnimeExtractorLoaded({required this.episodes});
  @override
  List<Object> get props => [episodes];
}

final class AnimeExtractorError extends AnimeExtractorState {}
