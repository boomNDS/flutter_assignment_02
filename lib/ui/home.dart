import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  String nametitle = "Todo";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("$nametitle"),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print("Pressed +");
                Navigator.pushNamed(context, "/add");
              },
            ),
          ]
          // centerTitle: true,
        ),
        bottomNavigationBar: Material(
          color: Colors.indigo,
          child: TabBar(
            tabs: <Widget>[
                Tab(icon: Icon(Icons.list), text: "Task",),
                Tab(icon: Icon(Icons.done_all), text: "Completed"),
            ],
          )
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text("Task"),
            ),
            Center(
              child: Text("Completed"),
            )
          ],
        ),
      )
    );
  }

}