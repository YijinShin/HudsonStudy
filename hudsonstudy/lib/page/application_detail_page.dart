import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationDetailPage extends StatefulWidget {

  ApplicationDetailPage({
    @required this.applicant,
    @required this.studyName,
    @required this.addMyStudy,
    @required this.addMember,
    @required this.deleteApplication
  });
  final String applicant;
  final String studyName;
  final Future<void> Function(String userId, String studyName) addMyStudy;
  final Future<void> Function(String userId, String studyName) addMember;
  final Future<void> Function(String userId, String studyName) deleteApplication;

  @override
  _ApplicationDetailPageState createState() => _ApplicationDetailPageState();
}

class _ApplicationDetailPageState extends State<ApplicationDetailPage> {

  final ref = FirebaseFirestore.instance.collection('appUser');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  margin: EdgeInsets.fromLTRB(34, 0, 5, 0),
                  width: 90,
                  height: 90,
                  child:Image.asset('assets/user.png',fit: BoxFit.cover,),
                ),
                Row(
                  children: [
                    StreamBuilder(
                      stream: ref.doc('${widget.applicant}').snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData) return Container(width:10);
                        return Row(
                          children: [
                            Text('${snapshot.data['sureName']}',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400)),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
             Container(
              padding: EdgeInsets.fromLTRB(40, 50,20,0),
              child: Row(
                children: [
                  Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                  ),
                  SizedBox(width:20),
                  StreamBuilder(
                    stream: ref.doc('${widget.applicant}').snapshots(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData) return Container(width:10);
                      return Text(
                        '${snapshot.data['firstName']}  ${snapshot.data['sureName']}',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 50,20,0),
              child: Row(
                children: [
                  Text(
                    'Major',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                  ),
                  SizedBox(width:20),
                  StreamBuilder(
                    stream: ref.doc('${widget.applicant}').snapshots(),
                    builder: (context,snapshot){
                       if(!snapshot.hasData) return Container(width:10);
                      return Text(
                        '${snapshot.data['major']}',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 50,20,0),
              child: Row(
                children: [
                  Text(
                    'Contect',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                  ),
                  SizedBox(width:20),
                  StreamBuilder(
                    stream: ref.doc('${widget.applicant}').snapshots(),
                    builder: (context,snapshot){
                       if(!snapshot.hasData) return Container(width:10);
                      return Text(
                        '${snapshot.data['contect']}',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.4),
            Container(
              padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black),
                    ),
                    elevation:5.0,
                    child: Text('Reject',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
                    onPressed: (){
                      //application에서 지우기
                      widget.deleteApplication('${widget.applicant}', '${widget.studyName}');
                      //applicant한테 알림주기
                      //home_widget으로 돌아가기 
                       Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black),
                    ),
                    color: Colors.white,
                    elevation:5.0,
                    child: Text('Accept',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
                    onPressed: (){
                      //study> mem에 데이터 추가
                      widget.addMember('${widget.applicant}', '${widget.studyName}');
                      //appUser > myStudy에 데이터 추가 
                      widget.addMyStudy('${widget.applicant}', '${widget.studyName}');
                      //application에서 지우기
                      widget.deleteApplication('${widget.applicant}', '${widget.studyName}');
                      //applicant한테 알림주기
                      //home_widget으로 돌아가기 
                       Navigator.pop(context);
                    },
                  ),
                ],
              )
            )
          ],
        )
      ),
      
    );
  }
}