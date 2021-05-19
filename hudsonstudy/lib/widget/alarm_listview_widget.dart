import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

//page
import 'package:hudsonstudy/page/all_study_detail_page.dart';
import 'package:hudsonstudy/page/application_detail_page.dart';
//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';


class AlarmListViewWidget extends StatefulWidget {
  @override
  _AlarmListViewWidgetState createState() => _AlarmListViewWidgetState();
}

class _AlarmListViewWidgetState extends State<AlarmListViewWidget> {

  CollectionReference ref = FirebaseFirestore.instance.collection('application');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.snapshots(),
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
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return Consumer<ApplicationStateProvider>(
                            builder:(context, appState, _) => ApplicationDetailPage(
                              applicant: "${document['applicant']}",
                            )
                          );
                        } 
                      )
                    );
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
                        Text('${document['applicant']} 님이 스터디 신청을 했습니다!',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
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