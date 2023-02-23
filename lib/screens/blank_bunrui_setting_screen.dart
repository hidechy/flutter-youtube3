// ignore_for_file: use_build_context_synchronously

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../state/app_param/app_param_notifier.dart';
import '../state/device_info/device_info_notifier.dart';
import '../utility/utility.dart';
import '../viewmodel/video_notifier.dart';
import '_alert/bunrui_list_alert.dart';
import '_alert/setting_thumbnail_alert.dart';
import '_parts/bunrui_dialog.dart';
import 'home_screen.dart';

class BlankBunruiSettingScreen extends ConsumerStatefulWidget {
  const BlankBunruiSettingScreen({super.key, required this.contents});

  final List<DragAndDropList> contents;

  ///
  @override
  ConsumerState<BlankBunruiSettingScreen> createState() =>
      _BlankBunruiSettingScreenState();
}

class _BlankBunruiSettingScreenState
    extends ConsumerState<BlankBunruiSettingScreen> {
  final Utility _utility = Utility();

  TextEditingController bunruiText = TextEditingController();

  RegExp reg = RegExp('Text(.+)');

  List<String> bunruiItems = [];

  ///
  @override
  Widget build(BuildContext context) {
    final deviceInfoState = ref.read(deviceInfoProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Column(
            children: [
              const SizedBox(height: 50),

              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          BunruiDialog(
                            context: context,
                            widget: BunruiListAlert(),
                          );
                        },
                        icon: const Icon(Icons.list),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: bunruiText,
                      decoration: const InputDecoration(labelText: '分類'),
                    ),
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.withOpacity(0.3),
                          ),
                          onPressed: dispBunruiItem,
                          child: const Text(
                            '分類する',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: DragAndDropLists(
                  removeTopPadding: true,
                  children: widget.contents,
                  onItemReorder: _onItemReorder,
                  onListReorder: _onListReorder,
                  itemDecorationWhileDragging: const BoxDecoration(
                    color: Colors.blueGrey,
                    boxShadow: [
                      BoxShadow(color: Colors.white, blurRadius: 4),
                    ],
                  ),
                  lastListTargetSize: 0,
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.withOpacity(0.3),
                  ),
                  onPressed: displayThumbnail,
                  child: const Text(
                    'サムネイル表示',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  void _onItemReorder(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedItem = widget.contents[oldListIndex].children.removeAt(
        oldItemIndex,
      );
      widget.contents[newListIndex].children.insert(
        newItemIndex,
        movedItem,
      );
    });
  }

  ///
  void _onListReorder(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = widget.contents.removeAt(oldListIndex);
      widget.contents.insert(newListIndex, movedList);
    });
  }

  ///
  Future<void> dispBunruiItem() async {
    bunruiItems = [];

    for (final value in widget.contents) {
      var listName = '';
      final match = reg.firstMatch(value.header.toString());
      if (match != null) {
        listName = match
            .group(1)!
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('"', '');
      }

      if (listName == 'LIST_UP') {
        for (final child in value.children) {
          final match2 = reg.firstMatch(child.child.toString());
          if (match2 != null) {
            final item = match2
                .group(1)!
                .replaceAll('(', '')
                .replaceAll(')', '')
                .replaceAll('"', '');

            if (item != '-----') {
              final exItem = item.split(' // ');
              bunruiItems.add(exItem[1]);
            }
          }
        }
      }
    }

    if (bunruiItems.isNotEmpty) {
      bunruiItems.forEach((element) {
        /// notifier 動画のidを選択リストに追加する
        ref
            .watch(appParamProvider.notifier)
            .setYoutubeIdList(youtubeId: element);
      });

      /// notifier 動画の分類をセットする
      await ref
          .watch(videoManipulateProvider.notifier)
          .videoManipulate(flag: bunruiText.text);

      /// notifier 未分類の動画を取得する
      await ref.watch(blankBunruiVideoProvider.notifier).getBlankBunruiVideo();

      Navigator.pop(context);
    }
  }

  ///
  void displayThumbnail() {
    final shitamiItems = <Map<String, String>>[];

    for (final value in widget.contents) {
      var listName = '';
      final match = reg.firstMatch(value.header.toString());
      if (match != null) {
        listName = match
            .group(1)!
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('"', '');
      }

      if (listName == 'ALL') {
        for (final child in value.children) {
          final match2 = reg.firstMatch(child.child.toString());
          if (match2 != null) {
            final item = match2
                .group(1)!
                .replaceAll('(', '')
                .replaceAll(')', '')
                .replaceAll('"', '');

            if (item != '-----') {
              final exItem = item.split(' // ');
              final map = <String, String>{};
              map['title'] = exItem[0];
              map['youtube_id'] = exItem[1];
              shitamiItems.add(map);
            }
          }
        }
      }
    }

    BunruiDialog(
      context: context,
      widget: SettingThumbnailAlert(
        shitamiItems: shitamiItems,
        bunruiText: bunruiText,
      ),
    );
  }
}
