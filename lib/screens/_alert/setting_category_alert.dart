// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube3/state/setting_category/setting_category_notifier.dart';

import '../../extensions/extensions.dart';
import '../../models/category.dart';
import '../../viewmodel/category_notifier.dart';

class SettingCategoryAlert extends ConsumerWidget {
  SettingCategoryAlert({super.key, required this.category});

  final Category category;

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
              Text(category.bunrui),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('カテゴリー1'),
                    Divider(
                      color: Colors.white.withOpacity(0.3),
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('現在')),
                        Expanded(flex: 2, child: Text(category.category1)),
                      ],
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.3),
                      thickness: 2,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
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
                          ref
                              .watch(settingCategoryProvider.notifier)
                              .setInputedCategory1(value: value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('カテゴリー2'),
                    Divider(
                      color: Colors.white.withOpacity(0.3),
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('現在')),
                        Expanded(flex: 2, child: Text(category.category2)),
                      ],
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.3),
                      thickness: 2,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
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
                          ref
                              .watch(settingCategoryProvider.notifier)
                              .setInputedCategory2(value: value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    settingCategoryState.errorStr,
                    style: const TextStyle(color: Colors.yellowAccent),
                  ),
                  IconButton(
                    onPressed: () {
                      ref
                          .watch(settingCategoryProvider.notifier)
                          .inputCategory(bunrui: category.bunrui);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.input),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void makeTecs() {
    for (var i = 0; i < 2; i++) {
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
