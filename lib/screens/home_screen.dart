// ignore_for_file: must_be_immutable, use_decorated_box

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodel/category_notifier.dart';
import '_pages/category_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  List<TabInfo> tabs = [];

  int selectedIndex = 0;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeBigCategoryTab();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        //

        appBar: AppBar(
          elevation: 0,
          title: const Text('Video Category'),
          centerTitle: true,
          leading: const Icon(
            Icons.check_box_outline_blank,
            color: Colors.transparent,
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 60,
                      child: Column(
                        children: const [
                          Icon(Icons.calendar_today_sharp),
                          Text('Get'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 60,
                      child: Column(
                        children: const [
                          Icon(Icons.calendar_today_sharp),
                          Text('Publish'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.redAccent,
            tabs: tabs.map((TabInfo tab) {
              return Tab(text: tab.label);
            }).toList(),
          ),
        ),

        //

        body: TabBarView(
          children: tabs.map((tab) => tab.widget).toList(),
        ),

        //

        floatingActionButton: FabCircularMenu(
          ringColor: Colors.redAccent.withOpacity(0.3),
          fabOpenColor: Colors.redAccent.withOpacity(0.3),
          fabCloseColor: Colors.pinkAccent.withOpacity(0.3),
          ringWidth: 10,
          ringDiameter: 250,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.recycling, color: Colors.purpleAccent),
              onPressed: () {},
              // onPressed: () {
              //   Navigator.pushNamed(context, '/recycle');
              // },
            ),
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {},
              // onPressed: () {
              //   Navigator.pushNamed(context, '/special');
              // },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () {},
              // onPressed: () {
              //   Navigator.pushNamed(context, '/remove');
              // },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
              // onPressed: () {
              //   Navigator.pushNamed(context, '/search');
              // },
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.yellowAccent),
              onPressed: () {},
//               onPressed: () {
// //                videoSearchViewModel.getVideoData();
//
//                 Navigator.pushNamed(context, '/');
//               },
            ),
          ],
        ),
      ),
    );
  }

  ///
  void makeBigCategoryTab() {
    final bigCategoryState = _ref.watch(bigCategoryProvider);

    for (var i = 0; i < bigCategoryState.length; i++) {
      tabs.add(TabInfo(
        bigCategoryState[i].category1,
        CategoryPage(category1: bigCategoryState[i].category1),
      ));
    }
  }
}
