import 'package:flutter/material.dart';
import 'package:youtube3/extensions/extensions.dart';
import 'package:youtube3/screens/_parts/video_list_item.dart';

import '../../models/video.dart';

class CalendarVideoAlert extends StatelessWidget {
  const CalendarVideoAlert(
      {super.key,
      required this.thisDateData,
      required this.date,
      required this.pubget});

  final List<Video> thisDateData;
  final String date;
  final String pubget;

  ///
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: MediaQuery.of(context).size.height - 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(width: context.screenSize.width),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text('$pubget $date'),
              ],
            ),
            Divider(
              color: Colors.white.withOpacity(0.3),
              thickness: 2,
            ),
            Expanded(child: displayDateData()),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayDateData() {
    final list = <Widget>[];

    thisDateData.forEach((element) {
      list.add(
        Column(
          children: [
            VideoListItem(
              data: element,
              listAddDisplay: false,
              linkDisplay: true,
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
