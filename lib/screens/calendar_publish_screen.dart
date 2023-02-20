// ignore_for_file: must_be_immutable

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utility/utility.dart';
import '../viewmodel/video_notifier.dart';

class CalendarPublishScreen extends ConsumerWidget {
  CalendarPublishScreen({super.key});

  final Utility _utility = Utility();

  Map<DateTime, List<String>> eventsList = {};

  ///
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final focusDayState = ref.watch(focusDayProvider);

    final videoHistoryState = ref.watch(videoHistoryProvider);

    //--------------------------------------------- event

    var keepYmd = '';
    for (var i = 0; i < videoHistoryState.length; i++) {
      if (videoHistoryState[i].pubdate != keepYmd) {
        eventsList[DateTime.parse(videoHistoryState[i].pubdate)] = [];
      }

      eventsList[DateTime.parse(videoHistoryState[i].pubdate)]
          ?.add(videoHistoryState[i].pubdate);

      keepYmd = videoHistoryState[i].pubdate;
    }

    final events = LinkedHashMap<DateTime, List<dynamic>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(eventsList);

    List<dynamic> getEventForDay(DateTime day) {
      return events[day] ?? [];
    }
    //--------------------------------------------- event

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),

          ///////////// calendar
          Column(
            children: [
              const SizedBox(height: 40),
              TableCalendar(
                eventLoader: getEventForDay,

                ///
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.transparent),
                  selectedDecoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),

                  ///
                  todayTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  selectedTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  rangeStartTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  rangeEndTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  disabledTextStyle: TextStyle(color: Colors.grey),
                  weekendTextStyle: TextStyle(color: Colors.white),

                  ///
                  markerDecoration: BoxDecoration(color: Colors.white),
                  rangeStartDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                  rangeEndDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                  holidayDecoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Color(0xFF9FA8DA),
                      ),
                    ),
                  ),
                ),

                ///
                headerStyle: const HeaderStyle(formatButtonVisible: false),
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030, 12, 31),

                focusedDay: focusDayState,

                ///
                selectedDayPredicate: (day) {
                  return isSameDay(ref.watch(blueBallProvider), day);
                },

                ///
                onDaySelected: (selectedDay, focusedDay) {
                  onDayPressed(date: selectedDay);
                },

                ///
                onPageChanged: (focusedDay) {
                  onPageMoved(date: focusedDay);
                },
              ),
            ],
          ),
          ///////////// calendar
        ],
      ),
    );
  }

  ///
  void onDayPressed({required DateTime date}) {
    _ref.watch(blueBallProvider.notifier).setDateTime(dateTime: date);
    _ref.watch(focusDayProvider.notifier).setDateTime(dateTime: date);
  }

  ///
  void onPageMoved({required DateTime date}) {
    _ref.watch(focusDayProvider.notifier).setDateTime(dateTime: date);
  }
}

////////////////////////////////////////////////////////////
final focusDayProvider =
    StateNotifierProvider.autoDispose<FocusDayStateNotifier, DateTime>((ref) {
  return FocusDayStateNotifier();
});

class FocusDayStateNotifier extends StateNotifier<DateTime> {
  FocusDayStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}

////////////////////////////////////////////////////////////
final blueBallProvider =
    StateNotifierProvider.autoDispose<BlueBallStateNotifier, DateTime>((ref) {
  return BlueBallStateNotifier();
});

class BlueBallStateNotifier extends StateNotifier<DateTime> {
  BlueBallStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}
