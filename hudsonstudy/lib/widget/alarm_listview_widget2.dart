import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//page
import 'package:hudsonstudy/page/all_study_detail_page.dart';
import 'package:hudsonstudy/page/application_detail_page.dart';
//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';


class AlarmListViewWidget2 extends StatefulWidget {
  @override
  _AlarmListViewWidget2State createState() => _AlarmListViewWidget2State();
}

class _AlarmListViewWidget2State extends State<AlarmListViewWidget2> {

  String currentUserEmail = FirebaseAuth.instance.currentUser.email;
  CollectionReference ref = FirebaseFirestore.instance.collection('application');
  CollectionReference userRef = FirebaseFirestore.instance.collection('appUser');
  //String currentUserEmail = FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userRef.doc('$currentUserEmail').collection('alarm').snapshots(),
      builder: (context, snapshot){
        //if no study > text
        if(!snapshot.hasData){
          return Center(child: Text('There are no alarm\n',style: TextStyle(color: Colors.grey)));
        }
        //else > study listview
        else{
          return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              children: snapshot.data.docs.map<Widget>((document){
                  return GestureDetector(
                    onTap: (){
                      // alarm type이 application이면 ApplicationDetailPage로 넘어간다. 
                      if('${document['type']}' == 'application'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context){
                              return Consumer<ApplicationStateProvider>(
                                builder:(context, appState, _) => ApplicationDetailPage(
                                  applicant: "${document['applicant']}",  
                                  studyName: "${document['studyName']}",
                                  addMyStudy: (String userId, String studyName,) => appState.addStudyToMyStudy(userId, studyName),
                                  addMember: (String userId, String studyName,) => appState.addMemberToMember(userId, studyName),
                                  deleteApplication : (String userId, String studyName,) => appState.deleteApplication(userId, studyName),
                                  updateAcceptAlarm : (String userId, String studyName,) => appState.updateAcceptAlarm(userId, studyName),
                                  updateRejectAlarm : (String userId, String studyName,) => appState.updateRejectAlarm(userId, studyName),
                                )
                              );
                            } 
                          )
                        );
                      }
                      else print("this alarm type : '${document['type']}'");
                      // alarm type이 appect나 apply면 아무일도 일어나지 않는다. 
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20,0,20,10),
                      padding: EdgeInsets.fromLTRB(30,20,30,13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black12, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.4,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if('${document['type']}' == 'application')
                            Text(
                              ' ${document['studyName']}이 신청을 했습니다!',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          if('${document['type']}' == 'reject')
                            Text(
                              ' ${document['studyName']}신청이 거절당했습니다',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          
                          if('${document['type']}' == 'accept')
                            Text(
                              '축하합니다! ${document['studyName']}와 함께하게되었습니다!',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          if('${document['type']}' == 'apply')
                            Text(
                              '${document['studyName']}를 신청했습니다!',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height:4),
                          Text('${document['studyName']}',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),                      
                        ],
                      ),
                    ),
                  );
              }).toList()  
          );
        }
      },
    );
  }
}