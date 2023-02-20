// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/video.dart';
import '../../viewmodel/video_notifier.dart';

class SpecialVideoAlert extends ConsumerWidget {
  SpecialVideoAlert({super.key});

  Map<String, List<Video>> orderedSpecialVideoMap = {};

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
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              const SizedBox(height: 10),
              Expanded(child: displayOrderedSpecialVideoList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayOrderedSpecialVideoList() {
    final list = <Widget>[];

    final specialVideoState = _ref.watch(specialVideoProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}
