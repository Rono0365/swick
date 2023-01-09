import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:intl/intl.dart';

class FriendMess extends StatefulWidget {
  //in memory of the first messenger i built in highschool
  FriendMess({
    Key? key,
    required this.title,
    required this.imageme,
    required this.token,
    required this.user,
  }) : super(key: key);
  String title; //restaurant name
  String imageme;
  String token; //ofcouse this is for pass grant
  String user; //this is the user

  @override
  State<FriendMess> createState() => _FriendMessState();
}

class _FriendMessState extends State<FriendMess> {
  var now;
  var leo;
  List chatdata = [];
  final scrollController = ScrollController();
  final titleController = TextEditingController();
  Future getWeather3x() async {
    String token = widget.token.toString();

    print('here' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = //http://172.16.12.17:8000/
        await http.get(Uri.parse('http://192.168.100.12:7000/chat/'),
            headers: headers);
    var results = jsonDecode(utf8.decode(responsev.bodyBytes));
    setState(() {
      this.chatdata = results;
    });
    //print(utf8.decode(chatd));
  }

  Future createAlbum() async {
    print(utf8.encode(titleController.text));
    http.Response response1 = await http.post(
      Uri.parse('http://192.168.100.12:7000/chat/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, //'id','sender','message_me','receiver','time'
      body: jsonEncode(<String, String>{
        //'id': titleController.text,this is an autofield
        'name': widget.title.toString(), //groupbuy
        'sender': widget.user.toString(), //parent user
        'message_me': titleController.text, //ie '2/rono|re|amount|3
        'receiver': widget.title.toString(), //you
        'time': now.toString() + '|' + leo.toString(),
      }),
    );
    //print(jsonDecode(response1.data.toString()) );
    //works => print(token['token']);

    if (response1.statusCode == 201) {
      print("yea it happened");
      print(jsonDecode(response1.body.toString()));
    }
    ;

    //});
//save the token for next time
  }

  @override
  void initState() {
    super.initState();
    getWeather3x();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          actions: [
            Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(widget.imageme.toString()),
                )),
            SizedBox(),
          ],
          leading: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
              child: Center(
                  child: Stack(children: [
                Icon(Icons.arrow_back_ios, color: Colors.blueGrey[900]),
              ])),
              onPressed: () {
                Navigator.pop(context);
                //search starts here
              }),
          flexibleSpace: new ClipRect(
              child: Container(
            height: MediaQuery.of(context).size.height * .23,
            decoration: BoxDecoration(
              //color: Colors.transparent,

              gradient: LinearGradient(
                colors: <Color>[
                  Colors.white,
                  Colors.white,
                  //Colors.white,
                  Colors.yellow.shade50,
                  Colors.yellow.shade100,
                  Colors.yellow.shade200,
                ],
              ),
              //color:Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(
                      0.0) //                 <--- border radius here
                  ),
            ),
            //height: 200,
            width: MediaQuery.of(context).size.width,
            //
          )),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Chip(label: Text(widget.title.toString()))),
      body: Column(
        children: [
          Expanded(
            child: chatdata != null
                ? Container(
                    padding: EdgeInsets.all(16),
                    height: MediaQuery.of(context).size.height * 0.78,
                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Text("swickchat "),
                            Text(
                              "(beta version)",
                              style: TextStyle(color: Colors.grey),
                            ),
                            //Text('hello').where((x)
                            ...chatdata.map((u) => u['name']
                                    .contains(widget.title.toString())
                                ? u['receiver'] != widget.user.toString() &&
                                        u['sender'] != widget.title.toString()
                                    ? Column(
                                        children: [
                                          InkWell(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(

                                                      //alignment: Alignment.topRight,
                                                      child: Container(
                                                    //alignment: Alignment.topRight,
                                                    constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.65,
                                                    ),

                                                    padding: EdgeInsets.all(5),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: u['sender'] !=
                                                                  widget.title
                                                                      .toString()
                                                              ? Colors.yellow
                                                                  .shade200
                                                              : Colors.green),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                20.0),
                                                        topRight:
                                                            Radius.circular(
                                                                20.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                20.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                chatdata.last ==
                                                                        u
                                                                    ? 0.0
                                                                    : 20.0),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors
                                                              .yellow.shade50,
                                                          spreadRadius: 1,
                                                          blurRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Card(
                                                      elevation: 0.0,
                                                      child: Column(
                                                        //mainAxisAlignment: MainAxisAlignment.end,

                                                        children: [
                                                          Text(
                                                            u['message_me'],
                                                            //textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .grey[900]),
                                                          ),
                                                          //ListTile()
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                                ]),
                                            onTap: () async {
                                              /* var Data = await GetData(
                                                                    'http://192.168.100.20:5000/api?Query=' +
                                      litems[Index]);*/
                                            },
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                u['time'].split('|').first !=
                                                        now.toString()
                                                    ? Text(
                                                        u['time']
                                                            .split('|')[0]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                            color: Colors.grey),
                                                      )
                                                    : Text(''),
                                                Text(' '),
                                                Text(
                                                  u['time']
                                                      .split('|')[1]
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ]),
                                          // now  u['time'].substring(0,14)
                                          //hey mr tambourine man

//                                              : Container(),
                                        ],
                                      )
                                    : Column(children: [
                                        InkWell(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(

                                                    //alignment: Alignment.topRight,
                                                    child: Container(
                                                  //alignment: Alignment.topRight,
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                  ),

                                                  padding: EdgeInsets.all(5),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.green),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              chatdata.last == u
                                                                  ? 0.0
                                                                  : 20.0),
                                                      bottomRight:
                                                          Radius.circular(20.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .green.shade50,
                                                        spreadRadius: 1,
                                                        blurRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  child: Card(
                                                    elevation: 0.0,
                                                    child: Column(
                                                      //mainAxisAlignment: MainAxisAlignment.end,

                                                      children: [
                                                        Text(
                                                          u['message_me'],
                                                          //textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors
                                                                  .grey[900]),
                                                        ),

                                                        //Text('time')
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                              ]),
                                          onTap: () async {
                                            /* var Data = await GetData(
                                                                    'http://192.168.100.20:5000/api?Query=' +
                                      litems[Index]);*/
                                          },
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                u['time'] != 'now'
                                                    ? u['time'].split('|')[1]
                                                    : '',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ])
                                      ])
                                : Container())
                          ],
                        )))
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
          Row(children: <Widget>[
            Container(
              padding: EdgeInsets.all(7),
              //height: 50,
              width: MediaQuery.of(context).size.width * 0.87,
              child: Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  maxLines: null,
                  onChanged: (value) {
                    setState(() {
                      //DateFormat('EEEE').format(date);
                      this.now =
                          DateFormat('EEEE d MMM').format(DateTime.now());
                      //returns json body from api
                      //this.courseblock = result1;
                      this.leo = DateFormat.jm().format(DateTime.now());
                    });
                    enabled:
                    false;
                  },

                  //void man => value.toString();

                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.storefront),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      hintText: 'Message',
                      hintStyle: TextStyle(color: Colors.grey[900]),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0))),
                  controller: titleController,
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            GestureDetector(
              // Redraw the Stateful Widget

              onTap: () async {
                if (titleController.text.length > 0) {
                  setState(() {
                    createAlbum();
                    titleController.clear();
                    getWeather3x();
                    getWeather3x();
                    getWeather3x();
                    scrollController.animateTo(1000,
                        duration: Duration(milliseconds: 50),
                        curve: Curves.ease);
                  });
                } else {
                  getWeather3x();
                } /*                litems.add(titleController.text.toString());
                                _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 60),
                                    curve: Curves.fastOutSlowIn);
                                
                                if (titleController.text.length > 0) {
                                  Data = await GetData(
                                      'http://192.168.100.20:5000/api?Query=' +
                                          titleController.text.toString());
                                  litems2.add(json.decode(Data));
                                  // Append Text to the list
                                  //ItemScrollController _scrollController = ItemScrollController();
                                  //       _scrollController.jumpTo(pos);

                                  titleController.clear();
                                  // Clear the Text area
                                  setState(() {});
                                  clearText();

                                  sleep(const Duration(milliseconds: 500));

                                  
                                  return litems2;
                                } else {
                                  try {
                                    if (titleController.text.length > 0) {
                                      litems2.add("Am Offline for the moment");
                                    }
                                  } catch (e) {
                                    titleController.clear();
                                  }

                                  ;
                                }
                              }*/
              },

              child: CircleAvatar(
                child: Icon(Icons.send),
              ),
              onLongPress: () {},
            ),
            SizedBox(width: 5),
          ]),
        ],
      ),
    );
  }
}
