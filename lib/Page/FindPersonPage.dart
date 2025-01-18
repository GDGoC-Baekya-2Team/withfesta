import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindPersonpage extends StatefulWidget {
  const FindPersonpage({super.key});

  @override
  State<FindPersonpage> createState() => _FindPersonpageState();
}

class _FindPersonpageState extends State<FindPersonpage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: const Text("find person",style: TextStyle(color: Colors.black)),
    );
  }
}
