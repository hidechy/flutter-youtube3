// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/category.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';
import '../_parts/bunrui_dialog.dart';
import 'setting_category_alert.dart';

class BunruiListAlert extends ConsumerWidget {
  BunruiListAlert({super.key});

  final Utility _utility = Utility();

  List<Category> bunruiList = [];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Expanded(child: displayCategoryList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayCategoryList() {
    final list = <Widget>[];

    final bunruiMapState = _ref.watch(bunruiMapProvider);

    bunruiMapState.forEach((key, value) {
      final category1 = value['category1'];
      final category2 = value['category2'];

      final color = (category1 == 'null' || key == '')
          ? Colors.blueAccent.withOpacity(0.2)
          : Colors.transparent;

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
            color: color,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text('cate1')),
                        Expanded(flex: 2, child: Text(category1!)),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('cate2')),
                        Expanded(flex: 2, child: Text(category2!)),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text('bunrui')),
                        Expanded(
                          flex: 2,
                          child: Text((key == '') ? '---' : key),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  BunruiDialog(
                    context: _context,
                    widget: SettingCategoryAlert(
                      category: Category(
                        category1: category1,
                        category2: category2,
                        bunrui: key,
                      ),
                    ),
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
