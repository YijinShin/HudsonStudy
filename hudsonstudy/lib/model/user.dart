import 'package:flutter/foundation.dart';

class AppUser{
  const AppUser({
    @required this.userId,
    @required this.firstName, 
    @required this.sureName,
    @required this.major,  
    @required this.contect,
  }) :assert(sureName != null),
      assert(firstName != null),
      assert(userId != null);
  
  final String userId;
  final String firstName;
  final String sureName;
  final String major;
  final String contect;

}