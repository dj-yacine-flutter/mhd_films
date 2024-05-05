part of 'movie_extractor_cubit.dart';

sealed class MovieExtractorState extends Equatable {
  const MovieExtractorState();
  @override
  List<Object> get props => [];
}

final class MovieExtractorLoading extends MovieExtractorState {}

final class MovieExtractorLoaded extends MovieExtractorState {
  final List<String> iframes;
  const MovieExtractorLoaded({required this.iframes});
  @override
  List<Object> get props => [iframes];
}

final class MovieExtractorError extends MovieExtractorState {}
