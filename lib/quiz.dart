import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Quiz(),
));

List<String> questions = ['Quiz 1','Quiz 2', 'Quiz 3', 'Quiz 4'];

class Quiz extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Map data = ModalRoute.of(context).settings.arguments;
    final String title = data['title'];

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(title),
          centerTitle: true,
          backgroundColor: Colors.purple[400],
        ),
      body: Center(
        child: MaterialButton(
          color: Colors.cyan,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ),
          child: Text(
            'Start quiz',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: (){
            Navigator.pushNamed(context, '/questionLoop',);
          },
        ),
      ),
    );
  }
}
