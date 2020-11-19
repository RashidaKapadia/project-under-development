import 'package:flutter/material.dart';
import 'package:frontend/requests/notifications.dart';
import 'package:frontend/trivia/triviaOngoing.dart';
import 'package:frontend/trivia/triviaResultMultiplayer.dart';
import 'package:frontend/widgets/buttons.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:frontend/widgets/fonts.dart';
import 'package:frontend/widgets/layout.dart';
import 'navbar.dart';

class NotificationBoard extends StatefulWidget {
  @override
  _NotificationBoardState createState() => _NotificationBoardState();
}

class _NotificationBoardState extends State<NotificationBoard> {
  var isSelected = false;
  String username = "";

  void loadUsername() {
    FlutterSession().get('username').then((value) {
      this.setState(() {
        username = value.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  gotoTrivia(BuildContext context, int actionId) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => TriviaOngoing(gameId: actionId)));
  }

  gotoTriviaResults(BuildContext context, int actionId) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            TriviaResultMulti(username: username, gameId: actionId)));
  }

  // Action factory
  Widget getActions(BuildContext context, int id, int actionId, String type,
      String category) {
    if (type == "invite" && category == "trivia") {
      return greyButtonFullWidth(
        () {
          deleteNotifications(username, [id]);
          gotoTrivia(context, actionId);
        },
        Text("Accept Invitation"),
      );
    } else if (type == "results" && category == "trivia") {
      return greyButtonFullWidth(
        () {
          markReadNotifications(username, [id]);
          gotoTriviaResults(context, actionId);
        },
        Text("See Results"),
      );
    } else {
      return Text("");
    }
  }

  // Tag factory
  Widget getTag(String value) {
    if (value == "trivia") {
      return tag(value, 240, 210, 160); // orange
    } else if (value == "invite") {
      return tag(value, 190, 200, 250); // blue
    } else if (value == "results") {
      return tag(value, 190, 245, 160); // green
    } else {
      return tag(value, 220, 220, 220); // grey
    }
  }

  Widget notificationHeader(int id, String type, String category) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      vmargin5(Row(children: [
        getTag(type),
        hmargin5(getTag(category)),
      ])),
      GestureDetector(
          child: Icon(Icons.delete, color: Colors.red[300], size: 20),
          onTap: () => deleteNotifications(username, [id]))
    ]);
  }

  TableRow notification({
    BuildContext context,
    String type,
    String category,
    String title,
    int id,
    int actionId,
  }) {
    //
    return TableRow(
        decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey[200], width: 1)),
        ),
        children: [
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: margin10(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    notificationHeader(id, type, category),
                    hmargin5(bold(title)),
                    vmargin5(getActions(context, id, actionId, type, category))
                  ])))
        ]);
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
        child: Table(
            border: TableBorder.all(
                color: Colors.black26, width: 1, style: BorderStyle.none),
            children: [
          notification(
              context: context,
              id: 0,
              type: "invite",
              category: "trivia",
              actionId: 100,
              title: "You got an invitation from Bob"),
          notification(
              context: context,
              id: 1,
              type: "results",
              category: "trivia",
              actionId: 100,
              title:
                  "You got an invitation from Bob he would like to play 1 on 1 trivia with you. Would you like to join?"),
          notification(
              context: context,
              id: 2,
              type: "other",
              category: "other",
              actionId: 100,
              title: "aew afe waefi faefj oafweif oawfj aefoi awefijfa wef A?"),
        ]));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pushNamed("/homepage")),
            title: Text("Notifications", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: Colors.brown[300]),
        bottomNavigationBar: NavBar(1),
        body: body(context));
  }
}
