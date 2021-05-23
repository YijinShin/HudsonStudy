import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hudsonstudy/model/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';


Widget memberDrawerWidget(BuildContext context, String studyName){

  CollectionReference ref = FirebaseFirestore.instance.collection('study').doc('$studyName').collection('member');

  
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
              '$studyName',
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
                return Container(
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
                                '${document['firstName']}  ${document['sureName']}',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)                      ,
                              ),
                              SizedBox(width:6),
                              if(document['master'])
                                Icon(FontAwesomeIcons.crown, size: 17,),
                            ],
                          ),
                          Text(
                            '${document['major']}',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)
                          ),
                          Text(
                            '${document['contect']}',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)
                          ),
                        ],
                      )
                    ],
                  )
                );
              }).toList(),
            );
          },
        ),
      ],
    ),
  );
}