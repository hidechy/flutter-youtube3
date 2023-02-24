// ignore_for_file: must_be_immutable, cascade_invocations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube3/state/setting_category/setting_category_notifier.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';

class BunruiListAlert extends ConsumerWidget {
  BunruiListAlert({super.key, required this.tecs});

  final List<TextEditingController> tecs;

  final Utility _utility = Utility();

  List<String> bunruiList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeBunruiList();

    final bunruiMapState = _ref.watch(bunruiMapProvider);

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: MediaQuery.of(context).size.height - 50,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bunruiList.map(
                  (value) {
                    final category1 = bunruiMapState[value]?['category1'];
                    final category2 = bunruiMapState[value]?['category2'];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(3),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await ref
                                      .watch(settingCategoryProvider.notifier)
                                      .setInputedCategory1(
                                        value: category1 ?? '',
                                      );

                                  await ref
                                      .watch(settingCategoryProvider.notifier)
                                      .setInputedCategory2(
                                        value: category2 ?? '',
                                      );

                                  tecs[0].text = category1 ?? '';
                                  tecs[1].text = category2 ?? '';
                                  tecs[2].text = value;
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.input,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                              DefaultTextStyle(
                                style: const TextStyle(color: Colors.grey),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(category1 ?? ''),
                                    Text(category2 ?? ''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void makeBunruiList() {
    bunruiList = [];

    final bigCategoryState = _ref.watch(bigCategoryProvider);

    bigCategoryState.forEach((element) {
      final smallCategoryState =
          _ref.watch(smallCategoryProvider(element.category1));

      smallCategoryState.forEach((element2) {
        bunruiList.add(element2.bunrui);
      });
    });
  }
}
