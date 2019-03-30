import 'package:flutter/material.dart';
import 'todo.dart';

class TodoScreen extends StatelessWidget{
  TodoProvider todo = TodoProvider();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Todo Screen")
      ),
      body: Column(
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
              print(result);
            },
          ),
          RaisedButton(
            child: Text("update"),
            onPressed: () async{
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
            onPressed: () async{
              Todo data = await todo.getTodo(1);
              print("**************************");
              print(data.toMap());
              print("**************************");
            },
          ),
          RaisedButton(
            child: Text("delete"),
            onPressed: () async{
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
    );
  }

}