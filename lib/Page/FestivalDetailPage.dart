import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Data/Festival.dart';

class FestivalDetailPage extends ConsumerWidget {
  final Festival festival;

  const FestivalDetailPage({Key? key, required this.festival})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0,
        backgroundColor: Colors.blue[100],
        elevation: 0,

        actions: [
          IconButton(
            icon: Icon(Icons.mic, color: Colors.black),
            onPressed: () {
              // 마이크 기능 구현
            },
          ),
        ],
      ),
      body: SingleChildScrollView(physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 96,
                  color: Colors.blue[100],
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16,0,16,16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          festival.fstvlName ?? '축제 이름',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 16,
                  child: Container(
                    width: 140,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: festival.imgUrl != null
                          ? Image.network(
                        festival.imgUrl!,
                        fit: BoxFit.cover,
                      )
                          : Image.asset("asset/images/default_fest_img.png"),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 140), // 포스터와 겹치지 않도록 여백 추가
                  _buildInfoSection('축제 기간', '${_formatDate(festival.fstvlStart)} - ${_formatDate(festival.fstvlEnd)}', Icons.date_range),
                  _buildInfoSection('위치', festival.location ?? '정보 없음', Icons.location_on),
                  _buildInfoSection('주소', festival.rdnmadr ?? '정보 없음', Icons.map),
                  _buildInfoSection('주최', festival.mnnstNm ?? '정보 없음', Icons.business),
                  _buildInfoSection('연락처', festival.number ?? '정보 없음', Icons.phone),
                  SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // 예약 또는 추가 정보 페이지로 이동
                      },
                      child: Text('예약하기', style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.blue[700],
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
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


  Widget _buildInfoSection(String label, String value, IconData icon) {
    return Container(color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue[600], size: 30),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '날짜 정보 없음';
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

}
