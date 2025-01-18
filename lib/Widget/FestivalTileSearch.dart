import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../Data/Festival.dart';
import '../Page/FestivalDetailPage.dart';
import '../constant.dart';

class FestivaltileSearch extends ConsumerWidget {
  final Festival festival;

  const FestivaltileSearch({Key? key, required this.festival}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    String statusText;
    Color statusColor;
    DateTime now = DateTime.now();

    if (now.isBefore(festival.fstvlStart!)) {
      // 예정된 축제
      int daysLeft = festival.fstvlStart!.difference(now).inDays;
      statusText = 'D-$daysLeft';
      statusColor = Colors.blue;
    } else if (now.isAfter(festival.fstvlEnd!)) {
      // 지난 축제
      statusText = '종료';
      statusColor = Colors.grey;
    } else {
      // 진행 중인 축제
      statusText = '진행중';
      statusColor = Colors.green;
    }

    return GestureDetector(onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FestivalDetailPage(festival: festival),
        ),
      );
    },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        statusText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          festival.fstvlName!,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        SizedBox(height: 8),
                        Text(
                          festival.location!,
                          style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                '${DateFormat('yyyy.MM.dd').format(festival.fstvlStart!)} - ${DateFormat('yyyy.MM.dd').format(festival.fstvlEnd!)}',
                style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}