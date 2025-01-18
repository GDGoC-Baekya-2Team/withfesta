import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:withfesta/Data/Festival.dart';

import '../Widget/FestivalTile.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}
var fest1=Festival(1,"축제1",DateTime.now(),DateTime.now(),"전번~","장소 장소~","내가 주최함","주소");
var fest2=Festival(2,"축제2",DateTime.now(),DateTime.now(),"전번~","장소 장소~","내가 주최함","주소");
var fest3=Festival(3,"축제3",DateTime.now(),DateTime.now(),"전번~","장소 장소~","내가 주최함","주소");
var fest4=Festival(4,"축제4",DateTime.now(),DateTime.now(),"전번~","장소 장소~","내가 주최함","주소");


class _CalendarPageState extends ConsumerState<CalendarPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Festival>> events = {
    DateTime.utc(2025, 1, 20): [fest1],
    DateTime.utc(2025, 1, 21): [fest1],
    DateTime.utc(2025, 1, 22): [fest1,fest2],
    DateTime.utc(2025, 1, 23): [fest1,fest2],
    DateTime.utc(2025, 1, 25): [],
    DateTime.utc(2025, 1, 26): [fest4],
    DateTime.utc(2025, 1, 27): [],
    DateTime.utc(2025, 1, 28): [fest1,fest2,fest3,fest4],
    DateTime.utc(2025, 1, 29): [fest2, fest4],
    DateTime.utc(2025, 1, 30): [fest1, fest4],
  };


  @override
  void initState() {
    super.initState();
    // 예시 이벤트 데이터



  }

  List<Festival> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Column(
          children: [
            TableCalendar(
              calendarStyle: CalendarStyle(
                markersMaxCount: 4,
                markerSize: 8,
                markerDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: (day) {
                return events[day] ?? [];
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextFormatter: (date, locale) =>
                    DateFormat('yyyy년 MM월').format(date),
                titleCentered: true,
      
              ),
      
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 80)),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.twoWeeks,
              selectedDayPredicate: (day) {
                return isSameDay( _selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
      
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },

            ),
            const SizedBox(height: 20),
            Expanded(
              child: _selectedDay == null
                  ? Center(child: Text('날짜를 선택해주세요'))
                  : ListView(
                children: _getEventsForDay(_selectedDay!)
                    .map((event) => FestivalTile( festival:  event))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
