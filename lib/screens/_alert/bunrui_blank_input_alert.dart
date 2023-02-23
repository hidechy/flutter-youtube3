// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/video.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/setting_category/setting_category_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';
import '../_parts/video_list_item.dart';

class BunruiBlankInputAlert extends ConsumerWidget {
  BunruiBlankInputAlert({super.key, required this.video});

  final Video video;

  final Utility _utility = Utility();

  List<String> category1List = [];
  List<String> category2List = [];

  List<TextEditingController> tecs = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeTecs();

    makeCategoryList();

    final settingCategoryState = ref.watch(settingCategoryProvider);

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),

                //----------//
                if (deviceInfoState.model == 'iPhone')
                  _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                const SizedBox(height: 20),

                VideoListItem(
                  data: video,
                  listAddDisplay: false,
                  linkDisplay: false,
                ),

                Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 2,
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  child: DropdownButton(
                    value: settingCategoryState.selectedCategory1,
                    icon: const Visibility(
                      visible: false,
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    items: category1List.map((val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (value) {
                      /// notifier 選択されたcategory1をセット
                      ref
                          .watch(settingCategoryProvider.notifier)
                          .setSelectedCategory1(value: value!);
                    },
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: tecs[0],
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) {
                      /// notifier 入力されたcategory1をセット
                      ref
                          .watch(settingCategoryProvider.notifier)
                          .setInputedCategory1(value: value);
                    },
                  ),
                ),

                const SizedBox(height: 40),

                Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 2,
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                  ),
                  child: DropdownButton(
                    value: settingCategoryState.selectedCategory2,
                    icon: const Visibility(
                      visible: false,
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    items: category2List.map((val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (value) {
                      /// notifier 選択されたcategory2をセット
                      ref
                          .watch(settingCategoryProvider.notifier)
                          .setSelectedCategory2(value: value!);
                    },
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: tecs[1],
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) {
                      /// notifier 入力されたcategory2をセット
                      ref
                          .watch(settingCategoryProvider.notifier)
                          .setInputedCategory2(value: value);
                    },
                  ),
                ),

                const SizedBox(height: 40),

                Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 2,
                ),

                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: tecs[2],
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) {
                      // /// notifier 入力されたcategory2をセット
                      // ref
                      //     .watch(settingCategoryProvider.notifier)
                      //     .setInputedCategory2(value: value);
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  void makeTecs() {
    for (var i = 0; i < 3; i++) {
      tecs.add(TextEditingController(text: ''));
    }
  }

  ///
  void makeCategoryList() {
    category1List = [''];
    category2List = [''];

    final bigCategoryState = _ref.watch(bigCategoryProvider);

    final keepCategory2 = <String>[];

    bigCategoryState.forEach((element) {
      //---// category1
      if (element.category1 != '') {
        category1List.add(element.category1);
      }

      //---// category2
      final smallCategoryState =
          _ref.watch(smallCategoryProvider(element.category1));

      smallCategoryState.forEach((element2) {
        if (!keepCategory2.contains(element2.category2)) {
          if (element2.category2 != '') {
            category2List.add(element2.category2);
          }
        }

        keepCategory2.add(element2.category2);
      });
    });
  }
}