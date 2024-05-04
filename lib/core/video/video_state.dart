part of 'video_cubit.dart';

sealed class VideoState extends Equatable {
  const VideoState();
  @override
  List<Object> get props => [];
}

final class VideoLoading extends VideoState {}
final class VideoLoaded extends VideoState {
  final String link;
  final String referer;
  const VideoLoaded({required this.link, required this.referer});
  @override
  List<Object> get props => [link, referer];
}
final class VideoError extends VideoState {}
