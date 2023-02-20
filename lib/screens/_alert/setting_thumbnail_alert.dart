// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../_parts/bunrui_dialog.dart';
import 'setting_bunrui_alert.dart';

class SettingThumbnailAlert extends StatelessWidget {
  SettingThumbnailAlert(
      {super.key, required this.shitamiItems, required this.bunruiText});

  final List<Map<dynamic, dynamic>> shitamiItems;

  final TextEditingController bunruiText;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      title: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent.withOpacity(0.3),
        ),
        onPressed: displayBunruiName,
        child: const Text('分類名表示'),
      ),
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
              Expanded(child: displayThumbnail()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayThumbnail() {
    final list = <Widget>[];

    shitamiItems.forEach((element) {
      final imageUrl =
          'https://img.youtube.com/vi/${element['youtube_id']}/mqdefault.jpg';

      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 180,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/no_image.png',
                image: imageUrl,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              element['title'].toString(),
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.topRight,
              child: Text(
                element['youtube_id'].toString(),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  ///
  void displayBunruiName() {
    BunruiDialog(
      context: _context,
      widget: SettingBunruiAlert(bunruiText: bunruiText),
    );
  }
}
