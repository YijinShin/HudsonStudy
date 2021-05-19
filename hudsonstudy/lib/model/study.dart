import 'package:flutter/foundation.dart';

//DB에서 받아오는 용도 
class Study{
  const Study({
    @required this.name,
    @required this.category, 
    @required this.maxMemNumber, 
    @required this.currentMemNumber, 
    @required this.when, 
    @required this.introduction, 
    @required this.rule, 
    @required this.status,
    @required this.isPrivite,
    @required this.password,
    @required this.master,
  }) :assert(name != null);
  
  final String name;
  final String category;
  final int maxMemNumber;
  final int currentMemNumber;
  final String when;
  final String introduction;
  final String rule;
  final String status;
  final bool isPrivite;
  final String password;
  final String master;
}

//새 스터를 만들때 사용
class NewStudy{
   String name = '---';
   String category ='---';
   int maxMemNumber = 0;
   String when = '---';
   String introduction = '---';
   String rule ='---';
   bool isPrivite =false;
   String password ='---';
}