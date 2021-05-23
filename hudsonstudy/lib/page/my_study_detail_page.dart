import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';
//page
import 'package:hudsonstudy/page/edit_study_page.dart';
//widget
import 'package:hudsonstudy/widget/study_member_drawer.dart';

class MyStudyDetailPage extends StatefulWidget {

  MyStudyDetailPage({
    @required this.studyName,
    @required this.checkMaster
  });
  final String studyName;
  final Future<String> Function(String name) checkMaster;

  @override
  _MyStudyDetailPageState createState() => _MyStudyDetailPageState();
}

class _MyStudyDetailPageState extends State<MyStudyDetailPage> {

  final studyRef = FirebaseFirestore.instance.collection('study');
  String category, introduction, name, password, status, when, rules;
  bool isPrivite;
  int maxMemNumber;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed:(){Navigator.pop(context);}),
      ),
      extendBodyBehindAppBar: true,
      endDrawer: Consumer<ApplicationStateProvider>(
        builder:(context, appState, _) => MemberDrawerWidget(
          studyName: "${widget.studyName}",
        )
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: Image.asset('assets/studyDefaultImage.png',fit: BoxFit.fill),
          ),
          Expanded(
            child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10,10,0),
                    child: StreamBuilder(
                          stream: studyRef.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
                            name = '${snapshot.data['name']}';
                            isPrivite = snapshot.data['isPrivite'];
                            password = '${snapshot.data['password']}';
                            return Text(
                              '${snapshot.data['name']}',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                              overflow: TextOverflow.visible,
                            );
                          }, 
                        ),
                    ),
                  SizedBox(height:10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 10,50,0),
                        child: Row(
                          children: [
                            Icon(Icons.perm_identity,color: Colors.black,),
                            StreamBuilder(
                              stream: studyRef.doc('${widget.studyName}').snapshots(),
                              builder: (context,snapshot){
                                if(!snapshot.hasData){
                                  return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                                }
                                maxMemNumber = snapshot.data['maxMemNumber'];
                                return Text(
                                  '${snapshot.data['currentMemNumber']}' + '/' + '${snapshot.data['maxMemNumber']}',
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                                  overflow: TextOverflow.visible,
                                );
                              }, 
                            ),
                          ],
                        ),
                      ),
                      //master만 edit가능하게 고쳐야함. 
                      FutureBuilder(
                        future: widget.checkMaster('${widget.studyName}'),
                        builder: (context, snapshot){
                          if(snapshot.data.toString()  == 'true'){
                            return  Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                color: Colors.black,
                                child: Text('Edit',style: TextStyle(color: Colors.white),),
                                onPressed: () {  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context){
                                        return Consumer<ApplicationStateProvider>(
                                          builder:(context, appState, _) => EditStudyPage(
                                            category:category,
                                            introduction:introduction,
                                            isPrivite:isPrivite,
                                            maxMemNumber:maxMemNumber,
                                            name:name,
                                            password:password,
                                            status:status,
                                            when:when,
                                            rules:rules,
                                            updateStudy: (String category, String introduction, bool isPrivite, int maxMemNumber
                                                , String studyName, String password, String rule, String status, String when) => appState.updateStudy(category, introduction, isPrivite, maxMemNumber, studyName, password, rule, status, when)
                                          )
                                        );
                                      } 
                                    )
                                  );
                                },
                              ),
                            );
                          }
                          else return SizedBox(width:10);
                        }
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 0.7,
                    color: Colors.grey[400],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10,50,0),
                    child: Row(
                      children: [
                        Text('Category',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                        SizedBox(width: 10,),
                        StreamBuilder(
                          stream: studyRef.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
                            introduction = '${snapshot.data['introduction']}';
                            return Text(
                              '${snapshot.data['category']}',
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                              overflow: TextOverflow.visible,
                            );
                          }, 
                        ),
                      ]
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 30,
                    thickness: 0.7,
                    color: Colors.grey[400],
                  ),
                  //when
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10,50,0),
                    child: Row(
                      children: [
                        Text('When',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                        SizedBox(width: 10,),
                        StreamBuilder(
                          stream: studyRef.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
                            when = '${snapshot.data['when']}';
                            return Text(
                              '${snapshot.data['when']}',
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                              overflow: TextOverflow.visible,
                            );
                          }, 
                        ),
                      ]
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 30,
                    thickness: 0.7,
                    color: Colors.grey[400],
                  ),
                  //introdution
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(40, 10,50,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Introduction',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                        SizedBox(height: 7),
                        StreamBuilder(
                          stream: studyRef.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
                            introduction = '${snapshot.data['introduction']}';
                            return Text(
                              '${snapshot.data['introduction']}',
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                              overflow: TextOverflow.visible,
                            );
                          }, 
                        ),
                      ]
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 30,
                    thickness: 0.7,
                    color: Colors.grey[400],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(40, 10,50,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Study rules',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                        SizedBox(height: 7),
                        StreamBuilder(
                          stream: studyRef.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
                            rules = '${snapshot.data['rule']}';
                            return Text(
                              '${snapshot.data['rule']}',
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                              overflow: TextOverflow.visible,
                            );
                          }, 
                        ),
                      ]
                    ),
                  ),
                  SizedBox(height: 40),
                ]
              ),
            ),
        ],
      ),
    );
  }
}