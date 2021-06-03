import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

//page
import 'package:hudsonstudy/page/all_study_detail_page.dart';

//widget
import 'package:hudsonstudy/widget/home_widget.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';


class HomeListViewWidget extends StatefulWidget {

  @override
  _HomeListViewWidgetState createState() => _HomeListViewWidgetState();
}

class _HomeListViewWidgetState extends State<HomeListViewWidget> {

  CollectionReference ref = FirebaseFirestore.instance.collection('study');
  CollectionReference queryRef = FirebaseFirestore.instance.collection('query');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.snapshots(),
      builder: (context, snapshot){
        //if no study > text
        if(!snapshot.hasData){
          return Center(child: Text('There are no studies.\nCreate a new study!',style: TextStyle(color: Colors.grey)));
        }
        //else > study listview
        else{
          return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              children: snapshot.data.docs.map<Widget>((document){
                return StreamBuilder(
                  stream: queryRef.doc('query').snapshots(),
                  builder: (context, snapshot){
                    print(" list widget query : ${snapshot.data['query']}");
                    if("${document['name']}".contains( '${snapshot.data['query']}')){
                      return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){
                                  return Consumer<ApplicationStateProvider>(
                                    builder:(context, appState, _) => AllStudyDetailPage(
                                      studyName: "${document['name']}",
                                      checkMyStudy: (String studyName) => appState.checkMyStudy(studyName),
                                      //addApplication: (String studyName) => appState.addApplicationToApplication(studyName),
                                      addApplication: (String studyName) => appState.addApplicationToAlarm(studyName),
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${document['name']}',style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),),
                                    Row(
                                      children: [
                                        Icon(Icons.perm_identity,color: Colors.black,),
                                        Text('${document['currentMemNumber']}' + '/' + '${document['maxMemNumber']}'),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height:4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('${document['category']}',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                                    if('${document['status']}' == '모집완료')
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey[400], width: 2),
                                        ),
                                        child: Text('${document['status']}'),
                                      ) 
                                    else
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.black12, width: 2),
                                        ),
                                        child: Text('${document['status']}'),
                                      ),
                                  ],                        
                                ),
                              ],
                            ),
                          ),
                        );
                    }
                    else return SizedBox(width:10);
                    
                  }
                );  
              }).toList()  
          );
        }
      },
    );
  }
}