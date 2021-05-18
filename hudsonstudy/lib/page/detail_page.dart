import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {

  DetailPage({
    @required this.studyName
  });
  final String studyName;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final ref = FirebaseFirestore.instance.collection('study');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
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
                    padding: EdgeInsets.fromLTRB(40, 10,50,0),
                    child: StreamBuilder(
                      stream: ref.doc('${widget.studyName}').snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                        }
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
                              stream: ref.doc('${widget.studyName}').snapshots(),
                              builder: (context,snapshot){
                                if(!snapshot.hasData){
                                  return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                                }
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
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          color: Colors.black,
                          child: Text('Apply',style: TextStyle(color: Colors.white),),
                          onPressed: () {    
                            print('apply!');
                          },
                        ),
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
                          stream: ref.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
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
                          stream: ref.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
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
                          stream: ref.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
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
                          stream: ref.doc('${widget.studyName}').snapshots(),
                          builder: (context,snapshot){
                            if(!snapshot.hasData){
                              return Center(child: Text('No item yet!',style: TextStyle(color: Colors.grey[300])));
                            }
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