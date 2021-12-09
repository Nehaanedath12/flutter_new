import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme:  ThemeData(
        primaryColor: Colors.blue
      ),
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int data=1000;
  int counter=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(data.toString(),textScaleFactor: 3,)),
      appBar: AppBar(
        title: Text("My App"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          data--;
          print(data);
        });
      },
      child: Icon(Icons.add),)

    );
  }
}


