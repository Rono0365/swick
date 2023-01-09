import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'netcloud.dart';
//import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppL extends StatefulWidget {
  @override
  _MyAppLState createState() => _MyAppLState();
}

class _MyAppLState extends State<MyAppL> {
  final titleController = TextEditingController();
  final titleController1 = TextEditingController();
  var passtok;
  String PassToken = '';
  String ID = '';
  final storage = new FlutterSecureStorage();
  var userid;
  var value;
  int State = 0;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtoken = sharedPreferences.getString('token');
    var idk = sharedPreferences.getString('key');
    //var idk = sharedPreferences.getString('key');

    setState(() {
      PassToken = obtoken;
      ID = idk;
    });
    print('another one' + PassToken);
    print('another tw' + ID);
  }

  @override
  void initState() {
    getValidation().whenComplete(() {
      PassToken != null
              ? Future.delayed(Duration.zero, () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp(
                              title: 'Swick', token: PassToken, userid: ID)));
                })
              : Container()
          //MyAppL()
          //.whenComplete(() async {

          ;
      //print("here she comes:" + userid);
    });

    super.initState();
  }

  Future createAlbum() async {
    http.Response response1 = await http.post(
      Uri.parse('http://192.168.100.12:7000/api-token-auth/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': titleController.text,
        'password': titleController1.text,
      }),
    );
    print(response1.statusCode);
    //works => print(token['token']);
    setState(() {
      State = response1.statusCode;
    });
    var token = jsonDecode(response1.body);
    print(token);
    if (response1.statusCode == 200) {
      setState(() async {
        passtok = token['token'].toString();
        userid = token['user_id'].toString();
        await storage.write(key: userid, value: passtok);
        value = storage.read(key: userid);
      });

      //});
//save the token for next time

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[700],
        body: PageView(children: [
          Container(
            color: Colors.white,
            child: Card(
                color: Colors.white,
                child: Center(
                    child: Column(children: [
                  //Image.asset('assets/judegroceries-removebg-preview.png'),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.35,
                  ),
                  Text(
                    "Dine-in order app," + '\n' + "Order and chill.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.30,
                  ),
                  //https://www.google.com/search?q=illustration+qr+code+drawing&sxsrf=APq-WBvyA863MRv7UgrxoUuglVUDFrRHhQ:1648523831027&tbm=isch&source=iu&ictx=1&vet=1&fir=gkZVKHnUvSESmM%252CYpTeIJ7_t3iUMM%252C_%253BSWMbnmfmxyvzMM%252Cwdng2dY126YtkM%252C_%253BvUcJA6ARjjWbYM%252Cf8Qjb9nHxR1BcM%252C_%253Bo0STY6lj_-dnoM%252C4quweExXGeEGZM%252C_%253Bt_QzcAXML7Gv-M%252CeNcvHA6qMiZqRM%252C_%253BJSiWvVkyQv-pWM%252Cf4gCUS9n_xuspM%252C_%253Bl8BN6QfbWTuFyM%252CilENFJ89gaqY0M%252C_%253BJ9Dg-_9fnUGkNM%252Cp1ssrBPOYBj5IM%252C_%253BZZv9k59aCYIP0M%252C-KAOCPBRIRsm4M%252C_%253BlOMJ-pVYka6Y7M%252Cf4gCUS9n_xuspM%252C_%253BU0Y1zjAnDEpb5M%252CBmlZjyL7xGa4eM%252C_%253B1vHR2KOqJLGBMM%252CU8952bWiHSODlM%252C_%253BFkYGDlKbmubZNM%252CGVIVM7GHjncykM%252C_%253BJvD09eOePrAOKM%252C4quweExXGeEGZM%252C_%253Bcm_Wg1BlTDa5vM%252CTwlHudSGR4KatM%252C_%253BjVwuN8HtKBpLnM%252CPN-TcZ5ImaGpRM%252C_%253BPT39wWSdWlz_PM%252CBmlZjyL7xGa4eM%252C_&usg=AI4_-kSl-z7SOeiaES8h-CeulpcDUSbnnA&sa=X&ved=2ahUKEwiakujqrer2AhUHyKQKHV85CdAQ9QF6BAgREAE#imgrc=o0STY6lj_-dnoM

                  Container(
                      height: MediaQuery.of(context).size.width * 0.60,
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: Image.network(
                          'https://media.istockphoto.com/vectors/smartphone-verification-with-qr-code-drawing-vector-id1207713126?k=20&m=1207713126&s=612x612&w=0&h=dePA_kF8-R4RS0TJnRrxwqiZySiVe_Ei6ZJ4ovCVeG4=')),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.20,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.86,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0),
                            spreadRadius: 0,
                            blurRadius: 0,
                          )
                        ],
                      ),
                      child: FlatButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => regS()));
                          }),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.20,
                  ),

                  Text(
                    "Swipe to Login>>>",
                  )
                  //Container(height: 100,width: MediaQuery.of(context).size.width,color: Colors.white,)
                ]))),
          ),
          Card(
            color: Colors.yellow[700],
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.35,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Image.asset('assets/play_store_512.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.30,
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          //fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          labelText: 'Username',
                          hintText: 'Enter your username'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: titleController1,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          //fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),

                          //border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      onPressed: () {
                        createAlbum().whenComplete(() async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString('token', passtok);
                          sharedPreferences.setString('key', userid);
                          setState(() {
                            PassToken = passtok;
                          });
                          if (State == 200) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp(
                                    title: titleController.text,
                                    token: passtok,
                                    userid: userid,
                                  ),
                                ));
                            print('exis' + passtok);
                          } else {
                            print('haiwork');
                            const snackBar = SnackBar(
                              content: Text(
                                  "Please Try Again! There's an error with your credentials"),
                            );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          ;
                        });

                        //print(State);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 130,
                  ),
                  Text('© 2022' + '\n' + '@Rono_Kenya',
                      textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
        ]));
  }
}
