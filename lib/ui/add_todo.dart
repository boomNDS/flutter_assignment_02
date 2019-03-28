import 'package:flutter/material.dart';
String nametitle = "New Subject";
class Add extends StatefulWidget{

  AddfromState createState() {
    // TODO: implement createState
    return AddfromState();
      }
}
class AddfromState extends State<Add>{
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _subject;
  String _pass;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("$nametitle"),
        ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(25, 30, 25, 30),
          child:Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Subject",
                  hintText: "Please insert Subject",
                  // icon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.text,
                onSaved: (subject) => print(subject),
                  validator: (value){
                    if(value.isEmpty){
                      return "Please insert Subject";
                    }else{
                      _subject = value;
                    }
                  },
              ),
              RaisedButton(
              child: Text('Save'),
              onPressed: () {
                print("Save");
                if(_formKey.currentState.validate() == false){
                  print("Please insert Subject");
                }else{
                  print("home");
                  Navigator.pop(context);
                  // Navigator.pushReplacementNamed(context, "/");
                }
              },
            ),
            ],
          ),
        ),
        ),
      );
  }

}