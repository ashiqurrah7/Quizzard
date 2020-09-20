import 'package:flutter/material.dart';

class Result extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

   final Map data = ModalRoute.of(context).settings.arguments;
   final int result = data['total'];
   final String course = data['course'];

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('You scored ', style: TextStyle(fontSize: 32),),
              Text(result.toString()+'/10', style: TextStyle(color:Colors.purple[400], fontSize: 72),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
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
                    ), onPressed: ()=> Navigator.pushNamed(context, '/leaderboard', arguments: {'course':course,'result':result}),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
