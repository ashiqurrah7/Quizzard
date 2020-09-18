import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: CourseList(),
));

List<String> courses = ['CSE 490','CSE 491', 'CSE 424', 'CSE 425'];

class CourseList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Courses'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
        backgroundColor: Colors.purple[400],
      ),
      body: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 80,
              child: MaterialButton (
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                      courses[index],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),),
                onPressed: (){

                },
              ),
            );
          }
      ),
    );
  }

}

class DataSearch extends SearchDelegate<String>{

  List<String> courses = ['CSE 490','CSE 491', 'CSE 424', 'CSE 425'];
  List<String> recent = ['CSE 490','CSE 491',];
  String selected = "";

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return[
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    //show results based on selection
    return Container(
      height: 100.0,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Card(
        child: MaterialButton(
          child: Center(
            child: Text(selected),
          ),
          onPressed: (){

          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Show search suggestions
    List suggestionList = query.isEmpty
        ? recent
        : courses.where((text)=>text.startsWith(query)).toList();
    
    return ListView.builder(itemBuilder: (context, index) => ListTile(
      onTap: (){
        selected = suggestionList[index];
        showResults(context);
      },
      leading: Icon(Icons.class_),
      title: RichText(text : TextSpan(
        text:  suggestionList[index].substring(0, query.length),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [TextSpan(
          text: suggestionList[index].substring(query.length),
          style: TextStyle(color: Colors.grey),
        )],
      )),
    ),
        itemCount: suggestionList.length,
    );
  }
  
}