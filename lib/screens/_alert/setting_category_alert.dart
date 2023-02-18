// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/category.dart';
import '../../viewmodel/category_notifier.dart';

class SettingCategoryAlert extends ConsumerWidget {
  SettingCategoryAlert({super.key});

  List<Category> blankCategoryList = [];
  List<String> category1List = [];
  List<String> category2List = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeCategoryList();

    print(category1List);

    print(category2List);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
//              Expanded(child: displayBlankCategory()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void makeCategoryList() {
    category1List = [];
    category2List = [];

    final bigCategoryState = _ref.watch(bigCategoryProvider);

    final keepCategory2 = <String>[];

    bigCategoryState.forEach((element) {
      if (element.category1 != '') {
        category1List.add(element.category1);
      } else {
        blankCategoryList.add(element);
      }

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
