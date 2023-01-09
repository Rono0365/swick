import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';

class screen extends StatefulWidget {
  const screen({Key? key}) : super(key: key);

  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {
  @override
  void initState() {
    super.initState();
    _navtohome();
  }

  _navtohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => MyAppL()));//MyHomePage(title: "myRiara")
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.width * 0.65,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Image.asset('assets/play_store_512.png'),),
          
              
        ],
      )),
      bottomNavigationBar: Container(
              height: MediaQuery.of(context).size.width * 0.10,
              width: MediaQuery.of(context).size.width * 0.10,
              child: Text("",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
    );
  }
}

         
           