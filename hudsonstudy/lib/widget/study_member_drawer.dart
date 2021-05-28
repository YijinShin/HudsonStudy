import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hudsonstudy/model/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';


class MemberDrawerWidget extends StatefulWidget {

  MemberDrawerWidget({
    @required this.studyName,
    @required this.deleteMember,
  });
  final String studyName;
  final Future<void> Function(String studyName, String memberId) deleteMember;
  @override
  _MemberDrawerWidgetState createState() => _MemberDrawerWidgetState();
}

class _MemberDrawerWidgetState extends State<MemberDrawerWidget> {

  void _deleteDialog(String memberId) { 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Center(
            child: Text(
              "잠깐!",
              //style: TextStyle(color: Colors.orange[600]),
            )
          ),
          content: Text("정말 멤버를 삭제하시겠습니까?"),
          actions: <Widget>[ 
            FlatButton(
              color: Colors.orange[600],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              child: Text(
                "아니오",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              color: Colors.orange[600],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              child: new Text(
                "확인",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                //delete member
                widget.deleteMember('${widget.studyName}',memberId );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection('study').doc('${widget.studyName}').collection('member');
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 70,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                '${widget.studyName}',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
              ),
            ),
          ),
          StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, snapshot){
              //if no study > text
              if(!snapshot.hasData){
                return Center(child: Text('There are no alarm\n',style: TextStyle(color: Colors.grey)));
              }
              return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: snapshot.data.docs.map<Widget>((document){
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        print('member >> ${document['userId']}');
                        _deleteDialog('${document['userId']}');
                        print('hello');
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            //decoration: BoxDecoration(color: Colors.blue),
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Image.asset('assets/user.png',fit: BoxFit.fill,)
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${document['firstName']} ${document['sureName']}',
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)                      ,
                                  ),
                                  SizedBox(width:6),
                                  if(document['master'])
                                    Icon(FontAwesomeIcons.crown, size: 17,),
                                ],
                              ),
                              Text(
                                '${document['major']}',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)
                              ),
                              Text(
                                '${document['contect']}',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)
                              ),
                            ],
                          )
                        ],
                      )
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    ); 
  }
}
