import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Data/Festival.dart';

class FestivalDetailPage extends ConsumerWidget {
  final Festival festival;

  const FestivalDetailPage({Key? key, required this.festival}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(festival.fstvlName ?? 'Festival Detail'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.blue[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    festival.fstvlName ?? 'Unknown Festival',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${festival.fstvlStart?.toString().substring(0, 10)} - ${festival.fstvlEnd?.toString().substring(0, 10)}',
                    style: TextStyle(fontSize: 16, color: Colors.blue[600]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.phone, '연락처', festival.number ?? 'N/A'),
                  _buildInfoRow(Icons.location_on, '위치', festival.location ?? 'N/A'),
                  _buildInfoRow(Icons.business, '주최', festival.mnnstNm ?? 'N/A'),
                  _buildInfoRow(Icons.map, '주소', festival.rdnmadr ?? 'N/A'),
                  SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // 예약 또는 추가 정보 페이지로 이동
                      },
                      child: Text('예약하기'),
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.blue[700],
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue[600], size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]),
                ),
                SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
