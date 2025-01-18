import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:withfesta/screens/job_screen.dart';

class JobcreateScreen extends StatefulWidget {
  const JobcreateScreen({super.key});

  @override
  State<JobcreateScreen> createState() => _JobcreateScreenState();
}

class _JobcreateScreenState extends State<JobcreateScreen> {

  final TextEditingController jobController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController payController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '',
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
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "새 구인글 등록",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Divider(
                    color: Colors.grey, // 선 색상
                    thickness: 1.0, // 선 두께
                    height: 10, // 위, 아래 간격 조정
                  ),
                  _buildTextField("👥 job", jobController),
                  _buildTextField("📆 days", daysController),
                  _buildTextField("💰 pay", payController),
                  _buildTextField("📋 description", descriptionController, maxLines: 5),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("등록 완료"),
                content: Text("등록이 완료되었습니다."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("확인"),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff0e4194),
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
          ),
          child: Text(
            '작성하기',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 20.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ],
    );
  }
}
