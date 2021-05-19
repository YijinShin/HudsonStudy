import 'package:flutter/foundation.dart';

class Application{
  const Application({
    @required this.applicant,
    @required this.master, 
    @required this.studyName,  
  });
  final String applicant;
  final String master;
  final String studyName;
}
