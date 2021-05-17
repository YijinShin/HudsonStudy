import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; 

//page
import 'package:hudsonstudy/page/home_page.dart';
import 'package:hudsonstudy/page/start_page.dart';
//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    //changeNotifierProvider 하위에 있는건 다 listener가 된다.
    ChangeNotifierProvider(
      create: (context) => ApplicationStateProvider(),
      builder: (context, _) => MyApp(), 
    ),
  );
}





class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      routes: {
        '/home' : (context) => HomePage(),
      },
    );
  }
  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => StartPage(), 
      fullscreenDialog: true,
    );
  }

}
