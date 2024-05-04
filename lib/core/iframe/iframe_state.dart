part of 'iframe_cubit.dart';

sealed class IframeState extends Equatable {
  const IframeState();
  @override
  List<Object> get props => [];
}

final class IframeLoading extends IframeState {}

final class IframeLoaded extends IframeState {
  final List<String> iframes;
  const IframeLoaded({required this.iframes});
  @override
  List<Object> get props => [iframes];
}

final class IframeError extends IframeState {}
