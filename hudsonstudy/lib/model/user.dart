import 'package:flutter/foundation.dart';

class AppUser{
  const AppUser({
    @required this.email,
    @required this.firstname, 
    @required this.surename,
    @required this.major,  
    @required this.contect,
  }) :assert(surename != null),
      assert(firstname != null),
      assert(email != null);
  
  final String email;
  final String firstname;
  final String surename;
  final String major;
  final String contect;

}