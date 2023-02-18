// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';
import '_parts/bunrui_dialog.dart';
import 'video_list_page.dart';

class CategoryListPage extends ConsumerWidget {
  CategoryListPage({super.key, required this.category1});

  final String category1;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          SingleChildScrollView(
            child: Column(
              children: [
                displaySmallCategory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displaySmallCategory() {
    final list = <Widget>[];

    final smallCategoryState = _ref.watch(smallCategoryProvider(category1));

    final getCategory = <String>[];

    smallCategoryState.forEach((element) {
      if (!getCategory.contains(element.category2)) {
        list.add(
          Stack(
            children: [
              Positioned(
                right: -50,
                top: -40,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      color: Colors.redAccent.withOpacity(0.5),
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ),

              //

              Positioned(
                left: -50,
                bottom: -40,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      color: Colors.redAccent.withOpacity(0.5),
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ),

              //

              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      element.category2,
                      style: const TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        BunruiDialog(
                          context: _context,
                          widget: VideoListPage(
                            category2: element.category2,
                          ),
                        );
                      },
                      child: const Icon(Icons.link),
                    ),
                  ],
                ),
              ),

              //
            ],
          ),
        );
      }

      getCategory.add(element.category2);
    });

    list.add(const SizedBox(height: 120));

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
