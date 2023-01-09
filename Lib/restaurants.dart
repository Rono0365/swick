import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'orders.dart';
//import 'comdata.dart';
//dear future rono please note that the receipt should be drawn from the backend!//so you have to pull data <3
class trakstar extends StatelessWidget {
  const trakstar({Key? key, required this.title}) : super(key: key);
  final List title;
  @override
  Widget build(BuildContext context) {
    List ttkes =[];
    List list_price = [];
    //var total => title[1].fold(0, (e, t) => e + t);
    //print()
    //final xc =Todo;
    //ttkes.add((int.parse(i['price'])*int.parse(title2)));
    return  Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(centerTitle:true,title:Text("Receipt",style:TextStyle(color:Colors.black)),elevation:0.0,backgroundColor:Colors.white)
      ,body:SingleChildScrollView(child:Column(children: [
      Text("You've ordered :"),
      ...this.title.map( 
                                                (i) =>ListTile(
        //leading: CircleAvatar(backgroundColor: Colors.yellow,child: Icon(Icons.fastfood,color: Colors.green,),),
        title: Text(i[0]['name'],style:TextStyle(color:Colors.black)),
        subtitle: Text(i[1].toString()),//
        trailing: Chip(backgroundColor:Colors.yellow,label: Text((int.parse(i[0]['price'])*int.parse(i[1].toString())).toString()+'\t'+"KES",style:TextStyle(fontWeight:FontWeight.bold))),
      )
      )
    ],)),
    //bottoma navigation bar
    
    );
  }
}