// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube3/screens/_alert/setting_category_alert.dart';
import 'package:youtube3/screens/_parts/bunrui_dialog.dart';

import '../../extensions/extensions.dart';
import '../../models/category.dart';
import '../../viewmodel/category_notifier.dart';

class BunruiListAlert extends ConsumerWidget {
  BunruiListAlert({super.key});

  List<Category> bunruiList = [];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeCategoryList();

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
              Expanded(child: displayCategoryList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void makeCategoryList() {
    bunruiList = [];

    final bigCategoryState = _ref.watch(bigCategoryProvider);

    final keepBunrui = <String>[];

    bigCategoryState.forEach((element) {
      final smallCategoryState =
          _ref.watch(smallCategoryProvider(element.category1));

      smallCategoryState.forEach((element2) {
        if (!keepBunrui.contains(element2.bunrui)) {
          bunruiList.add(element2);
        }

        keepBunrui.add(element2.bunrui);
      });
    });
  }

  ///
  Widget displayCategoryList() {
    final list = <Widget>[];

    bunruiList.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text('カテゴリー1')),
                        Expanded(flex: 2, child: Text(element.category1)),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('カテゴリー2')),
                        Expanded(flex: 2, child: Text(element.category2)),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('分類')),
                        Expanded(flex: 2, child: Text(element.bunrui)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  BunruiDialog(
                    context: _context,
                    widget: SettingCategoryAlert(category: element),
                  );
                },
                icon: Icon(
                  Icons.info,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
