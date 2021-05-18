import 'package:flutter/foundation.dart';

class AppUser{
  const AppUser({
    @required this.email,
    @required this.firstName, 
    @required this.sureName,
    @required this.major,  
    @required this.contect,
  }) :assert(sureName != null),
      assert(firstName != null),
      assert(email != null);
  
  final String email;
  final String firstName;
  final String sureName;
  final String major;
  final String contect;

}