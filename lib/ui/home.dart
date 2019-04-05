import 'package:flutter/material.dart';
import 'todo.dart';

TodoProvider todo = TodoProvider();

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  String nametitle = "Todo";
  List<Todo> list_undone = [];
  List<Todo> list_done = [];
  int lenall = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listbtn = [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          print("Pressed +");
          Navigator.pushNamed(context, "/add");
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          print("Del -");
          for (var item in list_done) {
            todo.delete(item.id);
          }
          setState(() {
            list_done = [];
          });
        },
      ),
    ];
    var list_view = new FutureBuilder<List<Todo>>(
      future: todo.getAllTodo(),
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
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
              // return new Text('Error: ${snapshot.error}');
              return new Center(
                child: Text("No data found..."),
              );
            } else {
              // return new Text('Result: ${snapshot.data[0].title}');
              return createListView(context, snapshot);
            }
        }
      },
    );
    final List<Widget> _children = [
      Center(
        child: list_view,
      ),
      Center(
        child: list_view,
      )
    ];
    return Scaffold(
      appBar: AppBar(
          title: Text("$nametitle"), actions: <Widget>[listbtn[_currentIndex]]),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text('Task'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.done_all),
            title: new Text('Completed'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    list_undone = [];
    list_done = [];
    lenall = snapshot.data.length;
    for (var items in snapshot.data) {
      if (items.done == false) {
        list_undone.add(items);
      } else {
        list_done.add(items);
      }
    }
    if (_currentIndex == 0 && list_undone.length > 0) {
      return new ListView.builder(
        itemCount: list_undone.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                  title: new Text(list_undone[index].title),
                  leading: Text((index + 1).toString()),
                  trailing: Checkbox(
                    onChanged: (bool value) async {
                      setState(() {
                        list_undone[index].done = value;
                      });
                      todo.update(list_undone[index]);
                    },
                    value: list_undone[index].done,
                  )),
              new Divider(
                height: 2.0,
              ),
            ],
          );
        },
      );
    } else if (_currentIndex == 1 && list_done.length > 0) {
      return new ListView.builder(
        itemCount: list_done.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                  title: new Text(list_done[index].title),
                  leading: Text((index + 1).toString()),
                  trailing: Checkbox(
                    onChanged: (bool value) async {
                      setState(() {
                        list_done[index].done = value;
                      });
                      todo.update(list_done[index]);
                    },
                    value: list_done[index].done,
                  )),
              new Divider(
                height: 2.0,
              ),
            ],
          );
        },
      );
    } else {
      return new Center(
        child: Text("No data found.."),
      );
    }
  }
}
