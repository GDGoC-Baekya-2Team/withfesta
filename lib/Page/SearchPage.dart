import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Data/Festival.dart';
import '../Widget/FestivalTileSearch.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
getList(int index){
  List<Festival> list=[];
  for(int i=0; i<index;i++){
    list.add(Festival( // 실제 Festival 객체로 변경 필요
        index,'축제 $index', DateTime.now().add(Duration(days: index)), DateTime.now().add(Duration(days: index + 3)), "번호","장소","주최","상세 주소"));
  }
  return list;
}

class _SearchPageState extends State<SearchPage> {
  String _selectedTimeFilter = '예정 축제';
  String _selectedRegion = '전체';
  String _searchKeyword = '';
  List<Festival> _festivals = []; // 실제 축제 데이터로 초기화 필요

  @override
  void initState() {
    super.initState();
    // 여기서 실제 축제 데이터를 로드해야 합니다.
    _festivals = List.generate(
      20,
          (index) => Festival(
        index,
         '축제 ${index + 1}',
         DateTime.now().add(Duration(days: index)),
        DateTime.now().add(Duration(days: index + 3)),"number","loc","주최","주소"
      ),
    );
  }

  List<Festival> get filteredFestivals {
    return _festivals.where((festival) {
      final nameMatch = festival.fstvlName!.toLowerCase().contains(_searchKeyword.toLowerCase());
      final regionMatch = _selectedRegion == '전체' || festival.location == _selectedRegion;
      final timeMatch = _selectedTimeFilter == '예정 축제'
          ? festival.fstvlStart!.isAfter(DateTime.now())
          : festival.fstvlEnd!.isBefore(DateTime.now());
      return nameMatch && regionMatch && timeMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Festa', style: TextStyle(fontSize: 24,fontFamily: "leferispecialitalic")),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFestivals.length,
              itemBuilder: (context, index) {
                return FestivaltileSearch(festival: filteredFestivals[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedTimeFilter,
              items: ['지난 축제', '예정 축제']
                  .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 18)),
              ))
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedTimeFilter = newValue;
                  });
                }
              },
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedRegion,
              items: ['전체', '서울', '경기', '인천', '부산']
                  .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 18)),
              ))
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedRegion = newValue;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: '축제 검색...',
          hintStyle: TextStyle(fontSize: 20),
          prefixIcon: Icon(Icons.search, size: 30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(width: 2),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchKeyword = value;
          });
        },
      ),
    );
  }
}