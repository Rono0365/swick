import 'package:flutter/material.dart';
class traktar extends StatelessWidget {
  const traktar({Key? key, required this.title, required this.title1}) : super(key: key);
  final List title;
  final String title1;
  @override
  Widget build(BuildContext context) {
    List ttkes =[];
    List list_price = [];
    //var total => title[1].fold(0, (e, t) => e + t);
    print(title1.toString());
    //final xc =Todo;
    //ttkes.add((int.parse(i['price'])*int.parse(title2)));
    return
Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation:0.0,
        title: Row(children:[Text("Stuff i've Ordered",style:TextStyle(backgroundColor:Colors.black45)),InkWell(child:Tab(
           //onPressed:(){},
                                    /*icon:CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      
                                      child: CircleAvatar(
                                        child: Icon(Icons.store,
                                          color: Colors.green),
                                          backgroundColor: Colors.white,
                                      
                                    )),*/
                                    child: Text(
                                      "",
                                      style: TextStyle(color: Colors.black),
                                    ))),]),
 
 
 
        
      ),
      body: Center(
        child: SingleChildScrollView(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            ...title.reversed.map(
                                                (i) 
                                                //var index = sky.indexOf(i);
                                                =>   i['owner'].toString() != title1.toString() ?Container():
           Card(
              elevation:0.9,
              child:Column(children:[
              ListTile(
        leading: Text(i['time'].toString(),style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:21)),
        //trailing:Text(i['restaurantx'].toString())
        //title: Text('name',style:TextStyle(color:Colors.black)),
        ),
         ListTile(
        //leading: Text(i['time'].toString(),style:TextStyle(color:Colors.black)),
        title:Text(i['restaurantx'].toString()),
        subtitle: Text(i['table'].toString() == 'Menu'?"Pickup order":i['table'].toString()),//
        
        //title: Text('name',style:TextStyle(color:Colors.black)),
        ),
 ListTile(
        title:Text(i['food'].replaceAll('[[','(').replaceAll(']]',')').replaceAll('],','),').replaceAll('[','(').toString()),
        //title: Text((i['food']. replaceAll('[{','').replaceAll('count:',' '). replaceAll('image_url',''). replaceAll('}]','').split('}')).toString(),style:TextStyle(color:Colors.black)),
        trailing: Chip(backgroundColor:Colors.white,label: Text("")),
      ),
      ListTile(
        //leading: Text(i['time'].toString(),style:TextStyle(color:Colors.black)),
        title:Text('You spent a total of:'),
        subtitle: Text(i['totalprice'].toString()+'\tKES'),//
        
        //title: Text('name',style:TextStyle(color:Colors.black)),
        ),
      
      ]))

      //play within this boundaries
      ),
            
          ],
        )),
      ),
       /*bottomNavigationBar:Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
         children:[InkWell(child:Tab(
           //onPressed:(){},
                                    icon:CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      
                                      child: CircleAvatar(
                                        child: Icon(Icons.store,
                                          color: Colors.green),
                                          backgroundColor: Colors.white,
                                      
                                    )),
                                    child: Text(
                                      "Orders",
                                      style: TextStyle(color: Colors.black),
                                    ))),
                                    
                                    /*InkWell(child:Tab(
                                    icon: CircleAvatar(
                                      child: Icon(Icons.restaurant,
                                          color: Colors.green),
                                      backgroundColor: Colors.yellow,
                                    ),
                                    child: Text(
                                      "Menu",
                                      style: TextStyle(color: Colors.black),
                                    )),onTap:(){
                                      Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>Rutimetable(
                                                  title:'1',
                                                  token: widget.token,
                                                  user:'Restaurant Menu'
                                                )
                                                    
                                                ), //MaterialPageRoute
                                          );


                                   
                                    }),
                                    InkWell(child:Tab(
                                    icon: CircleAvatar(
                                      child: Icon(Icons.query_stats,
                                          color: Colors.green),
                                      backgroundColor: Colors.yellow,
                                    ),
                                    child: Text(
                                      "Data",
                                      style: TextStyle(color: Colors.black),
                                    )),onTap:(){
                                      Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>stats(
                                                  title:'1',
                                                  token: widget.token,
                                                  user:'Restaurant Menu'
                                                )
                                                    
                                                ), //MaterialPageRoute
                                          );


                                   
                                    })*/
                                    
                                    ]),*/
      /*floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.green,//.withOpacity(0.9),
        onPressed: (){
          //getWeather();
          //rono = false;
        },//_incrementCounter,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );}}

