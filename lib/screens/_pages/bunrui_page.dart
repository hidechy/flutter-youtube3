// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../viewmodel/category_notifier.dart';

class BunruiPage extends ConsumerWidget {
  BunruiPage({super.key, required this.category2});

  final String category2;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),
                Text(category2),
                displayBunrui(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayBunrui() {
    final bunruiState = _ref.watch(bunruiProvider(category2));

    final list = <Widget>[];

    bunruiState.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
            ),
            // color: (appParamState.SeiyuAlertSelectDate == val)
            //     ? Colors.yellowAccent.withOpacity(0.3)
            //     : null,
          ),
          child: Text(element.bunrui),
        ),
      );
    });

    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: list),
      ),
    );
  }
}
