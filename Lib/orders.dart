import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'restaurants.dart';
//import 'comdata.dart';
class trak extends StatelessWidget {
  const trak({Key? key, required this.title, required this.title2, required this.title3}) : super(key: key);
  final List title;
  final List title3;//total amount 
  final String title2;
  @override
  Widget build(BuildContext context) {
    List ttkes =[];
    List list_price = [];
    List cart2 = [];
    num sum = 0;
    //var given_list = [1, 2, 3, 4, 5];
    for (var i = 0; i < title3.length; i++) {
      sum += title3[i];
      };
print("Sum : ${sum}");
    //var total => title[1].fold(0, (e, t) => e + t);
    //print()
    //final xc =Todo;
    //ttkes.add((int.parse(i['price'])*int.parse(title2)));
    return  Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(centerTitle:true,title:Text("Cart",style:TextStyle(color:Colors.black)),elevation:0.0,backgroundColor:Colors.white)
      ,body:SingleChildScrollView(child:Column(children: [
      Text("You're planning to order this foods/drinks"),
      ...this.title.map(
                                                (i) =>Dismissible(
                // Specify the direction to swipe and delete
                direction: DismissDirection.endToStart,
                key: Key(i),
                onDismissed: (direction) {
                  // Removes that item the list on swipwe
                  /*setState(() {
                    i.removeAt(index);
                  });*/
                  // Shows the information on Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("$i dismissed")));
                },
                background: Container(color: Colors.red),
                child:ListTile(
        //leading: CircleAvatar(backgroundColor: Colors.yellow,child: Icon(Icons.fastfood,color: Colors.green,),),
        title: Text(i[0]['name'],style:TextStyle(color:Colors.black)),
        subtitle: Text(i[1].toString()),//
        trailing: Chip(backgroundColor:Colors.yellow,label: Text((int.parse(i[0]['price'])*int.parse(i[1].toString())).toString()+'\t'+"KES",style:TextStyle(fontWeight:FontWeight.bold))),
      )))
    ],)),
    //bottoma navigation bar
    bottomNavigationBar:ListTile(title: Row(mainAxisAlignment:MainAxisAlignment.end,children:[Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:28,fontWeight:FontWeight.bold ,color:Colors.green))]),subtitle: FloatingActionButton.extended(
            backgroundColor: Colors.green,
            //icon: Icon(Icons.flatware_outlined),
            label: Text("Order"),
            onPressed: () {
              setState(){
                final cart = title;
                //cart2(title);
              };
               Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>trakstar(title:cart2),
                        ),
                      );
            } //scanQR(),
            

            // This trailing comma makes auto-formatting nicer for build methods.
        ),),
    );
  }
}