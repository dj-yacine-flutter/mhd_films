import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mhd_films/utils/extractor.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoLoading());

  Future<void> extract(String url) async {
    emit(VideoLoading());
    final link = await extractUrl(url);
    if (link != "not-found") {
      emit(VideoLoaded(
        link: link,
        referer: url,
      ));
    } else {
      emit(VideoError());
    }
  }

  void error() {
    emit(VideoError());
  }
}
