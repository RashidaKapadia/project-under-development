import 'package:flutter/material.dart';
// import 'package:frontend/InitialPage.dart';
import 'package:frontend/trivia/triviaPickCategory.dart';
import 'package:frontend/trivia/triviaMode.dart';
import 'package:frontend/changePassword.dart';
import 'package:frontend/trivia/triviaResult.dart';
import 'package:frontend/trivia/triviaSearchOpponent.dart';
import 'changeContact.dart';
import './signup_page.dart';
import './welcome_page.dart';
import './loginPage.dart';
import './homepage.dart';
import './settings.dart';
import './theZone.dart';
import './HTTPRequestExample.dart';
import './profile_page.dart';
import './ACSHistory_page.dart';
import 'notificationBoard.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          accentColor: Colors.orangeAccent, primaryColor: Colors.orangeAccent),
      title: 'SportCred',
      home: SportCredApp(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/profile': (context) => ProfilePage(),
        '/homepage': (context) => HomePage(),
        '/changePassword': (context) => ChangePassword(),
        '/changeContact': (context) => ChangeContact(),
        "/test": (context) => HTTPRequestExample(),
        '/trivia/mode': (context) => TriviaModePage("basketball"),
        '/trivia/category': (context) => TriviaPickCategoryPage(),
        '/trivia/solo/result': (context) => TriviaResult(),
        '/trivia/searchOpponent': (context) =>
            TriviaSearchOpponentPage("basketball"),
        '/settings': (context) => Settings(),
        "/profile/ACSHistory": (context) => ACSHistoryPage(),
        '/notifications': (context) => NotificationBoard(),
        '/theZone': (context) => TheZone()
      }));
}

class SportCredApp extends StatefulWidget {
  @override
  _SportCredAppState createState() => _SportCredAppState();
}

class _SportCredAppState extends State<SportCredApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
