import 'package:flutter/material.dart';

Widget memberDrawerWidget(BuildContext context, String studyName){
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('$studyName'),
        ),
      ],
    ),
  );
}