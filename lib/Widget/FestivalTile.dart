import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Data/Festival.dart';
import '../Page/FestivalDetailPage.dart';
import '../constant.dart';

class FestivalTile extends ConsumerWidget {
  final Festival festival;

  const FestivalTile({Key? key, required this.festival}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FestivalDetailPage(festival: festival),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.blue[100]!, Colors.blue[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  festival.fstvlName ?? 'Unknown Festival',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: mainColor),
                    SizedBox(width: 4),
                    Text(
                      '${festival.fstvlStart?.toString().substring(0, 10)} - ${festival.fstvlEnd?.toString().substring(0, 10)}',
                      style: TextStyle(fontSize: 14, color: mainColor),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: mainColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        festival.location ?? 'Unknown Location',
                        style: TextStyle(fontSize: 14, color: mainColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


