import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'setting_category_state.dart';

////////////////////////////////////////////////
final settingCategoryProvider = StateNotifierProvider.autoDispose<
    SettingCategoryNotifier, SettingCategoryState>((ref) {
  return SettingCategoryNotifier(
    const SettingCategoryState(),
  );
});

class SettingCategoryNotifier extends StateNotifier<SettingCategoryState> {
  SettingCategoryNotifier(super.state);

  Future<void> setSelectedCategory1({required String value}) async =>
      state = state.copyWith(selectedCategory1: value);

  Future<void> setInputedCategory1({required String value}) async =>
      state = state.copyWith(inputedCategory1: value);

  Future<void> setSelectedCategory2({required String value}) async =>
      state = state.copyWith(selectedCategory2: value);

  Future<void> setInputedCategory2({required String value}) async =>
      state = state.copyWith(inputedCategory2: value);

  ///
  Future<void> inputCategory() async {
    print(state);

/*
    flutter: SettingCategoryState(selectedCategory1: entertainment, inputedCategory1: , selectedCategory2: entertainment, inputedCategory2: )
*/

    var cate1 = (state.selectedCategory1 != '')
        ? state.selectedCategory1
        : state.inputedCategory1;

    var cate2 = (state.selectedCategory2 != '')
        ? state.selectedCategory2
        : state.inputedCategory2;

    if (cate1 == '' || cate2 == '') {
      state = state.copyWith(errorStr: 'category no set');
    }
  }
}

////////////////////////////////////////////////
