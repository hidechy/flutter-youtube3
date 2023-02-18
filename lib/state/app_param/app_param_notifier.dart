import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_param_state.dart';

////////////////////////////////////////////////
final appParamProvider =
    StateNotifierProvider.autoDispose<AppParamNotifier, AppParamState>((ref) {
  return AppParamNotifier(
    const AppParamState(selectedBunrui: '', youtubeIdList: []),
  );
});

class AppParamNotifier extends StateNotifier<AppParamState> {
  AppParamNotifier(super.state);

  ///
  Future<void> setSelectedBunrui(
          {required String category2, required String bunrui}) async =>
      state = state.copyWith(selectedBunrui: '$category2|$bunrui');

  ///
  Future<void> setYoutubeIdList({required String youtubeId}) async {
    final youtubeIdList = [...state.youtubeIdList];

    if (youtubeIdList.contains(youtubeId)) {
      final list = <String>[];
      youtubeIdList.forEach((element) {
        if (element != youtubeId) {
          list.add(element);
        }
      });
      state = state.copyWith(youtubeIdList: list);
    } else {
      youtubeIdList.add(youtubeId);
      state = state.copyWith(youtubeIdList: youtubeIdList);
    }
  }
}

////////////////////////////////////////////////
