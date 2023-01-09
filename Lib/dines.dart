import 'package:flutter/material.dart';

class events extends StatelessWidget {
  const events({Key? key, required this.title1}) : super(key: key);
 final List title1;
  //final title2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(elevation:0.0,backgroundColor:Colors.white),
      body:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 12,
                                      width: 7,
                                      color: Colors.deepPurple,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900]),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: 10,
                              ),
                              
                             Material(
                                                color: Colors.green.shade200
                                                    .withOpacity(0.2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(20.0),
                                                    topRight: Radius.circular(20.0),
                                                    bottomLeft: Radius.circular(20.0),
                                                    bottomRight: Radius.circular(20.0),
                                                  ),
                                                ),
                                                child: Card(
                                                  
                                                  elevation: 0.0,
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.5),
                                                  child: Column(
                                                    children: [
                                                      
                                                      
                                                      ListTile(
                                                        title: Text('Java'),//rest name
                                                        subtitle: Text('Mbagathi way'),//location
                                                        trailing: Chip(
                                                          backgroundColor: Colors.green[50],
                                                          avatar: Icon(
                                                                    Icons
                                                                        .star_outlined,
                                                                    color: Colors.red,
                                                                    size: 19,
                                                                  ),label: Text('Restaurant')),
                                                      ),
                                                      ListTile(
                                                        title:Wrap(
                                                          children:[
                                                            Chip(label:Text("Tables")),
                                                            Text('\t'),
                                                            Chip(label:Text("DineIn")),
                                                            Text('\t'),
                                                            Chip(label:Text("TakeOut"))
                                                          ]
                                                        
                                                        )
                                                      ),
                                                      
                                                      
                                                    ],
                                                  ),
                                                )),
                      ]));}}