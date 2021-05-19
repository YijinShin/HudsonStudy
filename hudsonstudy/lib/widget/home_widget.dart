import 'package:flutter/material.dart';
import 'package:hudsonstudy/page/start_page.dart';
import 'package:provider/provider.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';
//page
import 'package:hudsonstudy/page/profile_page.dart';
import 'package:hudsonstudy/page/create_study_page1.dart';
import 'package:hudsonstudy/page/alarm_page.dart';
//widget
import 'package:hudsonstudy/widget/home_listview_widget.dart';


class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white10,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.alarm,color: Colors.black), 
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlarmPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  width: 120,
                  height: 120,
                  child: FlatButton(
                    child: Image.asset('assets/user.png',fit: BoxFit.fill,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  )
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
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(35, 0, 10,10),
                    height: 50,
                    child: TextFormField(
                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: ' Find the study you want!',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.7),
                          borderSide: BorderSide(color: Colors.black12, width: 2),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[300], width: 3.0),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                      controller: _searchController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: IconButton(
                    icon: Icon(Icons.search_outlined), 
                    onPressed: (){}
                  ),
                ),
              ],
            ),
            //home_listview()
            HomeListViewWidget(),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateStudyPage1()),
          );
        },
      ),
    );
  }
}
