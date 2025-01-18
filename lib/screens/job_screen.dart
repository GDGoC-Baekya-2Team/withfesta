import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:withfesta/screens/jobCreate_screen.dart';
import 'package:withfesta/screens/jobDetail_screen.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {

  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;

  final String apiUrl = 'http://43.203.143.150:8080/api/recruits';

  Duration durationBetween(DateTime from, DateTime to) {
    return to.difference(from);
  }

  @override
  void initState() {
    super.initState();
    _fetchRecruits(); // 게시물 목록 로드
  }

  Future<void> _fetchRecruits() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final decodedData = json.decode(utf8.decode(response.bodyBytes));

        // "data" 키에서 게시글 데이터 추출
        final List<dynamic> data = decodedData["data"] ?? [];

        setState(() {
          _posts = data.map((item) => item as Map<String, dynamic>).toList();
        });
      } else {
        // ... (기존 코드)
      }
    } catch (e) {
      // ... (기존 코드)
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'withFesta',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "구인 게시판",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              )
            ),
            Container(
              color: Color(0xffdceffd),
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.symmetric(vertical: 26.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🔥 따끈따끈 최신 공고",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 120, // 스크롤할 높이를 설정
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator()) // 로딩 표시
                        : _posts.isEmpty
                        ? Center(child: Text("게시물이 없습니다.")) // 게시물 없음 표시
                        : SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // 가로로 스크롤
                      child: Row(
                        children: _posts.map((post) {
                          return Container(
                            width: 330,
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobdetailScreen(),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${post["job"]}',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    '${post["description"]}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "전체 3개",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobcreateScreen(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      BorderSide(color: Colors.grey, width: 1), // 회색 테두리 추가
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8), // 원하는 경우 모서리를 둥글게
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "새 글 등록",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _posts.isEmpty
                            ? Center(child: Text("게시글이 없습니다."))
                            : SingleChildScrollView(
                                child: Column(
                                  children: _posts.map((post) {
                                    final today = DateTime.now();
                                    final eventDate = DateTime.parse(post["days"]);
                                    final diff = durationBetween(today, eventDate);

                                    // D-day 표시 문자열 생성
                                    final daysLeft = diff.inDays.abs();
                                    String dDayString;
                                    if (daysLeft == 0) {
                                      dDayString = "D-day";
                                    } else if (daysLeft > 0) {
                                      dDayString = "D-$daysLeft";
                                    } else {
                                      dDayString = "마감";
                                    }

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey, width: 1.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10.0),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  dDayString,
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "${post["days"]}", // 원래 코드 유지
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${post["job"]}',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    '${post["description"]}',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                    )
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     border: Border.all(color: Colors.grey, width: 1.2),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   margin: EdgeInsets.only(bottom: 10.0),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  //     child: Row(
                  //       children: [
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "D-5",
                  //               style: TextStyle(
                  //                 fontSize: 40,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //             Text(
                  //               "2025.01.23",
                  //               style: TextStyle(
                  //                 fontSize: 13,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(width: 10),
                  //         Expanded(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "서울특별시",
                  //                 style: TextStyle(
                  //                   fontSize: 17,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Colors.black,
                  //                 ),
                  //               ),
                  //               SizedBox(height: 15),
                  //               Text(
                  //                 "한강불꽃축제 주차 진행도우미 모집",
                  //                 style: TextStyle(
                  //                   fontSize: 20,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: Colors.black,
                  //                 ),
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 200,
                  //   child: _isLoading
                  //       ? Center(child: CircularProgressIndicator())
                  //       : _posts.isEmpty
                  //       ? Center(child: Text("게시물이 없습니다."))
                  //       : SingleChildScrollView(
                  //     child: Column(
                  //       children: _posts.map((post) {
                  //         // 날짜 계산
                  //         final today = DateTime.now();
                  //         final eventDate = DateTime.parse(post["days"]); // "days" 데이터를 파싱
                  //         final diff = durationBetween(today, eventDate);
                  //
                  //         // D-day 표시 문자열 생성
                  //         final daysLeft = diff.inDays.abs();
                  //         String dDayString;
                  //         if (daysLeft == 0) {
                  //           dDayString = "D-day";
                  //         } else if (daysLeft > 0) {
                  //           dDayString = "D-$daysLeft";
                  //         } else {
                  //           dDayString = "마감";
                  //         }
                  //
                  //         return Container(
                  //           // ... (기존 Container 스타일)
                  //           child: GestureDetector(
                  //             onTap: () {
                  //               // ... (기존 onTap 이벤트)
                  //             },
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text(
                  //                       dDayString, // 계산된 D-day 표시
                  //                       style: TextStyle(
                  //                         fontSize: 17,
                  //                         fontWeight: FontWeight.w500,
                  //                         color: Colors.black,
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       // 원래 코드 유지 (위치 조정 필요)
                  //                       "2025.01.23",
                  //                       style: TextStyle(
                  //                         fontSize: 13,
                  //                         fontWeight: FontWeight.w600,
                  //                         color: Colors.grey,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 SizedBox(height: 15),
                  //                 Text(
                  //                   "직업: ${post["job"]} 모집",
                  //                   style: TextStyle(
                  //                     // ... (기존 스타일)
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}