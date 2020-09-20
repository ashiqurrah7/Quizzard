import 'package:flutter/material.dart';
import 'package:quizzard/quizList.dart';

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

      Map passedData = ModalRoute.of(context).settings.arguments;
      print(passedData);
      // int newUser = passedData['result'];
      // String course = passedData['course'];
      //
      final int newUser = passedData['result'];
      final String course = passedData['course'];
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
                ), onPressed: ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) => QuizList(title: course,),
              ), ModalRoute.withName('/'))
              ),
            ],
          ),
        ),
      );
    }
}