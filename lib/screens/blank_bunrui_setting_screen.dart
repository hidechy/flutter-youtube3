import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utility/utility.dart';

class BlankBunruiSettingScreen extends StatefulWidget {
  const BlankBunruiSettingScreen({super.key, required this.list});

  final List<DragAndDropItem> list;

  ///
  @override
  State<BlankBunruiSettingScreen> createState() =>
      _BlankBunruiSettingScreenState();
}

class _BlankBunruiSettingScreenState extends State<BlankBunruiSettingScreen> {
  final Utility _utility = Utility();

  TextEditingController bunruiText = TextEditingController();

  List<DragAndDropList> contents = [];

  RegExp reg = RegExp('Text(.+)');

  List<String> bunruiItems = [];

  ///
  @override
  void initState() {
    super.initState();

    contents
      ..add(
        DragAndDropList(
          header: const Text('LIST_UP'),
          children: <DragAndDropItem>[
            DragAndDropItem(child: const Text('-----'))
          ],
        ),
      )
      ..add(
        DragAndDropList(
          header: const Text('ALL'),
          children: widget.list,
        ),
      );
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
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
                            backgroundColor: Colors.redAccent.withOpacity(0.3),
                          ),
                          onPressed: () {
                            dispBunruiItem();
                            //
                            // ref
                            //     .watch(videoSearchProvider.notifier)
                            //     .getVideoData();
                            //
                            // backHomeScreen(context: _context);
                            //
                            //
                          },
                          child: const Text('分類する'),
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
                  children: contents,
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
                    backgroundColor: Colors.redAccent.withOpacity(0.3),
                  ),
                  onPressed: () => displayThumbnail(),
                  child: const Text('サムネイル表示'),
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
      final movedItem = contents[oldListIndex].children.removeAt(oldItemIndex);
      contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  ///
  void _onListReorder(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = contents.removeAt(oldListIndex);
      contents.insert(newListIndex, movedList);
    });
  }

  ///
  Future<void> dispBunruiItem() async {
    bunruiItems = [];

    for (final value in contents) {
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
              bunruiItems.add("'${exItem[1]}'");
            }
          }
        }
      }

      print(bunruiItems);
    }
  }

  ///
  void displayThumbnail() {
    final shitamiItems = <Map<String, String>>[];

    for (final value in contents) {
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

    //
    //
    // showDialog(
    //   context: context,
    //   builder: (_) {
    //     return Dialog(
    //       backgroundColor: Colors.blueGrey.withOpacity(0.3),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(30),
    //       ),
    //       insetPadding: const EdgeInsets.all(30),
    //       child: ThumbnailAlert(
    //         shitamiItems: shitamiItems,
    //         bunruiList: _bunruiList,
    //         bunruiText: bunruiText,
    //       ),
    //     );
    //   },
    // );
    //
    //
  }
}
