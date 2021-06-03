import 'package:flutter/material.dart';

//widget
import 'package:hudsonstudy/widget/alarm_listview_widget.dart';
import 'package:hudsonstudy/widget/alarm_listview_widget2.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        centerTitle: true,
        title: Text('notice', style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
        elevation: 0.0,
      ),
      //body: AlarmListViewWidget(),
      body: AlarmListViewWidget2(),
      
    );
  }
}