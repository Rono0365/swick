import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';

class screenxc2 extends StatefulWidget {
  const screenxc2({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _screenxc2State createState() => _screenxc2State();
}

class _screenxc2State extends State<screenxc2> {
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
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline,size:70),
          SizedBox(height:MediaQuery.of(context).size.height*0.1),
          Text("Your order  is set to"+'\n'+"${widget.title}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22), textAlign: TextAlign.center,),
          
          /*Container(
              height: MediaQuery.of(context).size.width * 0.45,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Image.asset('assets/play_store_512.png')),*/
          
              
        ],
      )),
      bottomNavigationBar: Container(
              height: MediaQuery.of(context).size.width * 0.10,
              width: MediaQuery.of(context).size.width * 0.10,
              child: Text("",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
    );
  }
}

         
           