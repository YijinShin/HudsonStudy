import 'package:flutter/foundation.dart';

class Study{
  const Study({
    @required this.id,
    @required this.name, 
    @required this.price, 
    @required this.description, 
    @required this.thumb, 
    @required this.photoURL, 
    @required this.photoName, 
    @required this.userId,
  }) :assert(name != null),
      assert(price != null);
  
  final String id;
  final String name;
  final int price;
  final String description;
  final int thumb;
  final String photoURL;
  final String photoName;
  final String userId;
}

