// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/video.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////
final videoListProvider =
    StateNotifierProvider.autoDispose<VideoListNotifier, List<Video>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return VideoListNotifier([], client, utility);
});

class VideoListNotifier extends StateNotifier<List<Video>> {
  VideoListNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getVideoList({required String bunrui}) async {
    await client.post(
      path: APIPath.getYoutubeList,
      body: {'bunrui': bunrui},
    ).then((value) {
      final list = <Video>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(Video.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
