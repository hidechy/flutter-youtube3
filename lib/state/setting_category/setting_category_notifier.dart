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
  }
}

////////////////////////////////////////////////
