import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: QuizList(),
));

List<String> quizes = ['Quiz 1','Quiz 2', 'Quiz 3', 'Quiz 4'];

class QuizList extends StatelessWidget {

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
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(quizes.length, (index) {
            return Container(
              child: MaterialButton(
                child: Text(
                  quizes[index],
                  style: Theme.of(context).textTheme.headline5,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz', arguments: {'title':quizes[index]});
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)
                ),
              ),
            );
          })
      ),
    );
  }
}

