import 'package:flutter/material.dart';

class Result extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

   int result = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('You scored '+result.toString()),
            MaterialButton(
              color: Colors.yellow[700],
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
            MaterialButton(
              color: Colors.cyan,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Text('View Leader board',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ), onPressed: ()=> Navigator.pushNamed(context, '/leaderboard', arguments: result),
            )
          ],
        ),
      ),
    );
  }
}
