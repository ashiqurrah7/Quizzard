import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  List<Map> data = [
    {'name': 'User 1', 'score': 5},
    {'name': 'User 2', 'score': 10},
    {'name': 'User 3', 'score': 8},
  ];

  void sort() {
      data.sort((a, b) {
        int compare = b['score'].compareTo(a['score']);
        return compare;
      });
  }

     @override
     Widget build(BuildContext context) {

      int newUser = ModalRoute.of(context).settings.arguments;
      data.add({'name': 'You', 'score': newUser});
      sort();

      return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < data.length; i++)
                ListTile(
                  title: Text(
                    data[i]['name'] + '   ' + data[i]['score'].toString(),
                  ),
                  leading: Text('$i'),
                ),
              MaterialButton(
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Text('Go back to quizzes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ), onPressed: ()=> Navigator.popUntil(context, ModalRoute.withName('/quizList')),
              ),
            ],
          ),
        ),
      );
    }
}