import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<String> enrolled = ['CSE 490','CSE 491', 'CSE 424'];

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Icon(Icons.people),
                  Text('Hello User'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text('Settings'
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text('Quizzard'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/courseList');
            },
          ),
        ],
        backgroundColor: Colors.purple[400],
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(enrolled.length, (index) {
            return Container(
              child: MaterialButton(
                child: Text(
                  enrolled[index],
                  style: Theme.of(context).textTheme.headline5,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/quizList', arguments: {'title':enrolled[index]});
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