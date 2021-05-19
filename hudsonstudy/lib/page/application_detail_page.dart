import 'package:flutter/material.dart';

class ApplicationDetailPage extends StatefulWidget {

  ApplicationDetailPage({
    @required this.applicant
  });
  final String applicant;

  @override
  _ApplicationDetailPageState createState() => _ApplicationDetailPageState();
}

class _ApplicationDetailPageState extends State<ApplicationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        leading: BackButton(color: Colors.black),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              children: [
                 Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  width: 90,
                  height: 90,
                  child:Image.asset('assets/user.png',fit: BoxFit.cover,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Hi,',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300)),
                        Text('Yijin ',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Text('Computer Science',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  ],
                ),
              ],
            ),
          ],
        )
      ),
      
    );
  }
}