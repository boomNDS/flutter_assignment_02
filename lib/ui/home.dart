import 'package:flutter/material.dart';
import 'todo.dart';
import 'dart:async';
import 'dart:convert';

class Home extends StatelessWidget {
  String nametitle = "Todo";
  @override
  TodoProvider todo = TodoProvider();
  Widget build(BuildContext context) {
    // TODO: implement build
    todo.open("todo.db");
    var list_view = new FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return new Center(
              child: Text("loading..."),
            );
            break;
          default:
            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.error}');
            } else {
              return new Text('Result: ${todo.getAllTodo()}');
              // return createListView(context, snapshot);
            }
        }
      },
    );
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(title: Text("$nametitle"), actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print("Pressed +");
                Navigator.pushNamed(context, "/add");
              },
            ),
          ]),
          bottomNavigationBar: Material(
              color: Colors.indigo,
              child: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.list),
                    text: "Task",
                  ),
                  Tab(icon: Icon(Icons.done_all), text: "Completed"),
                ],
              )),
          body: TabBarView(
            children: <Widget>[
              Center(child: list_view),
              Center(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("openn DB"),
                      onPressed: () {
                        todo.open("todo.db");
                      },
                    ),
                    RaisedButton(
                      child: Text("insert"),
                      onPressed: () async {
                        Todo data = Todo();
                        data.title = "test";
                        data.done = false;
                        Todo result = await todo.insert(data);
                        print(result.title);
                      },
                    ),
                    RaisedButton(
                      child: Text("update"),
                      onPressed: () async {
                        Todo newData = Todo();
                        newData.id = 1;
                        newData.title = "new Test";
                        newData.done = true;

                        int result = await todo.update(newData);
                        print(result);
                      },
                    ),
                    RaisedButton(
                      child: Text("get"),
                      onPressed: () async {
                        Todo data = await todo.getTodo(2);
                        print("**************************");
                        print(data.toMap());
                        print("**************************");
                      },
                    ),
                    RaisedButton(
                      child: Text("getALl"),
                      onPressed: () async {
                        List<Todo> data = await todo.getAllTodo();
                        print("**************************");
                        // print(data);
                        data.forEach((x) => print(x.id));
                        print("**************************");
                      },
                    ),
                    RaisedButton(
                      child: Text("delete"),
                      onPressed: () async {
                        int result = await todo.delete(1);
                        print(result);
                      },
                    ),
                    RaisedButton(
                      child: Text("close db"),
                      onPressed: () {
                        todo.close();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    bool a = false;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
                title: new Text("Hello"),
                leading: Text(index.toString()),
                trailing: Checkbox(
                  onChanged: (bool value) {
                    a = (a = false ? true : false);
                  },
                  value: true,
                )),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  // Future<List<Todo>> _getData() async {
  //   print("getData");
  //   return null;
  // }
}

    Future<List<String>>  _getData() async{
      var values = new List<String>();
      values.add("Hello");
      values.add("A");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      values.add("NNNello");
      await new Future.delayed(new Duration(seconds: 2));
      return values;
}
