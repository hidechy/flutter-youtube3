// ignore_for_file: cascade_invocations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';

class SettingBunruiAlert extends ConsumerWidget {
  SettingBunruiAlert({super.key, required this.bunruiText});

  final TextEditingController bunruiText;

  final Utility _utility = Utility();

  List<String> bunruiList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeBunruiList();

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
                children: bunruiList
                    .map(
                      (value) => GestureDetector(
                        onTap: () => setBunruiName(
                          value: value,
                          context: context,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Text(value),
                        ),
                      ),
                    )
                    .toList(),
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

  ///
  void setBunruiName({required String value, required BuildContext context}) {
    bunruiText.text = value;

    Navigator.pop(context);
    Navigator.pop(context);
  }
}
