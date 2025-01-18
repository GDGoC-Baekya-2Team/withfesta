class Festival {
  Festival(this.festival_id,this.fstvlName,this.fstvlStart,this.fstvlEnd,this.number,this.location,this.mnnstNm,this.rdnmadr,{this.imgUrl=null});

  int festival_id=-1;
  String? fstvlName="";
  late DateTime? fstvlStart;
  late DateTime? fstvlEnd;
  String? number;
  String? location;
  String? mnnstNm;
  String? rdnmadr;
  String? imgUrl;

}