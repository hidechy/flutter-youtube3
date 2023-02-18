// ignore_for_file: must_be_immutable, cascade_invocations, use_decorated_box

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../viewmodel/category_notifier.dart';
import '../../viewmodel/video_notifier.dart';
import '_parts/video_list_item.dart';

class VideoListPage extends ConsumerWidget {
  VideoListPage({super.key, required this.category2});

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
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Text(category2),
              displayBunrui(),
              const SizedBox(height: 20),
              Expanded(
                child: displayVideoList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayBunrui() {
    final appParamState = _ref.watch(appParamProvider);

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
            color:
                (appParamState.selectedBunrui == '$category2|${element.bunrui}')
                    ? Colors.yellowAccent.withOpacity(0.3)
                    : null,
          ),
          child: GestureDetector(
            onTap: () {
              _ref.watch(appParamProvider.notifier).setSelectedBunrui(
                    category2: category2,
                    bunrui: element.bunrui,
                  );

              _ref
                  .watch(videoListProvider.notifier)
                  .getVideoList(bunrui: element.bunrui);
            },
            child: Text(element.bunrui),
          ),
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

  ///
  Widget displayVideoList() {
    final list = <Widget>[];

    final appParamState = _ref.watch(appParamProvider);

    final videoListState = _ref.watch(videoListProvider);

    videoListState.forEach((element) {
      list.add(
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: (appParamState.youtubeIdList.contains(element.youtubeId))
                    ? Colors.blueAccent.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: VideoListItem(
                data: element,
                listAddDisplay: true,
                linkDisplay: true,
              ),
            ),
            const Divider(color: Colors.white),
          ],
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
