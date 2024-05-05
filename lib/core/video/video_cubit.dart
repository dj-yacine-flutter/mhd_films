import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mhd_films/utils/extractor.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoLoading());

  Future<void> extract(List<String> iframes) async {
    emit(
      VideoLoading(),
    );
    for (final v in iframes) {
      final link = await extractUrl(v);
      if (link != "not-found") {
        emit(VideoLoaded(
          link: link,
          referer: v,
        ));
        return;
      }
    }
    emit(
      VideoError(),
    );
  }

  void error() {
    emit(
      VideoError(),
    );
  }
}
