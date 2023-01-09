//Rutimetable
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'orders.dart';
import 'preorder.dart';
//import 'mpesa.dart';
import 'thank.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'restaurants.dart';
import 'package:collection/collection.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'search2.dart';
import 'package:mpesa/mpesa.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Rutimetable extends StatefulWidget {
  Rutimetable(
      {Key? key,
      required this.title,
      required this.token,
      required this.user,
      required this.me})
      : super(key: key);
//, required this.title
  final String title;
  final String token;
  final String user;
  final String me;

  @override
  _RutimetableState createState() => _RutimetableState();
}

class _RutimetableState extends State<Rutimetable> {
  Future<void> startCheckout(
      {required String userPhone, required double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: "174379",
          callBackURL:
              Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
          accountReference: "${widget.me}",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey:
              'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

      print("TRANSACTION RESULT: " +
          transactionInitialisation['MerchantRequestID']);
      setState(() {
        transactionInitialisationx = transactionInitialisation.toString();
      });
      //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());

      /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
    }
  }

  //const Rutimetable({Key? key}) : super(key: key);
  var sky;
  var leo;
  String transactionInitialisationx = '';
  bool xon = false;

  //var newthing();
  var now;
  late var selectedTime = TimeOfDay.now();

  var week_area;
  bool pressedCart = true;
  Future getWeather() async {
    MpesaFlutterPlugin.setConsumerKey('rjDWHXkZ3RX5Gy4xDvNztA6ARJQo6gQx');
    MpesaFlutterPlugin.setConsumerSecret('kL2L4KMvGhZDqIZn');

    String token = widget.token;
    //http://192.168.100.12:7000/restaurant/ http://172.16.12.17:8000/
    print('rono' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token ${token}',
    };
    http.Response responsev = await http.get(
        Uri.parse('http://192.168.100.12:7000/restaurant/' + widget.title),
        headers: headers);
    var results = jsonDecode(responsev.body);
    setState(() {
      this.sky = results;
      /*[{name: bevarage, caption: hot sweet drinks ... you'll come back for more, food: [{name: vanilla latte, price: 250}, {name: Chips, price: 100}, {name: burger, price: 150}, {name: black coffee, price: 100}, {name: capucchino, price: 150}, {name: esspreso, price: 100}]}, {name: fastfood&drinks, caption: delicacies ... you'll come back for more, food: [{name: vanilla latte, price: 250}, {name: Chips, price: 100}, {name: burger, price: 150}, {name: black coffee, price: 100}, {name: capucchino, price: 150}, {name: esspreso, price: 100}, {name: croissant, price: 250}, {name: blackforrest, price: 250}, {name: red velvet, price: 250}, 
{name: Pilau, price: 100}]}]
*/
      //sky['menu'][0]['menu'] -this is the menu
      //sky['menu'][0]['menu'][0]['name'] this is the categries
      print(sky);
    });
    setState(() {
      //DateFormat('EEEE').format(date);
      this.week_area = DateFormat('d MMM').format(DateTime.now());
      this.leo = DateFormat.jm().format(DateTime.now());
      this.now = DateFormat('EEEE d MMM')
          .format(DateTime.now()); //returns json body from api
      print(leo);
      //this.courseblock = result1;
    });
  }

  List<List> cart = [];
  List amount = [];
  var quantity;
  List<List> cart2 = [];
  List amount2 = [];
  List amount3 = [];
  var quantity2;
  bool softkey = false;
  void _increase(var i) {
    final prev = ii;
    ii = i;
    if (prev != ii) {
      quantity = 1;
    }
    quantity++;
  }

  Future addtocart() async {
    String token = widget.token;
    var headers = {
      'Authorization': 'Token ${token}',
    };
    http.Response responsex =
        await http.post(Uri.parse('http://172.16.12.17:8000/cart/'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Token $token',
            },
            body: jsonEncode(<String, String>{
              'count': quantity.toString(),
              'food': amount2.toString(), //list for food
              //'customer':now.toString()+'\t ,'+leo.toString(),
            }));
  }

  Future addata(String otype, String zum, String otime, String oname) async {
    String token = widget.token;
    print('ruined sum' + zum.toString());
    print('rono' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token ${token}',
    };
    http.Response responsev =
        await http.post(Uri.parse('http://192.168.100.12:7000/order/'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Token $token',
            },
            body: jsonEncode(<String, String>{
              'table': widget.user.toString(),
              'food': '${amount2.toString()}', //list for food
              'restaurantx': sky['username'].toString(),
              'time': now.toString() + '\t ,' + leo.toString(),
              'owner': widget.me.toString(),
              //$sum
              'totalprice': zum.toString(),
              'ordertype': otype.toString(),
              'ordername': oname.toString(),
              'ordertrak': 'not ready',
              'ordertime': otime.toString(),
              //'customer':now.toString()+'\t ,'+leo.toString(),
            }));
    //returns json body from api
    //var resultsX = jsonDecode(responsevX.body); //returns json body from api
  }

  Future createAlbumx(
      String sender, String message_me, String receiver, String time) async {
    //print(utf8.encode(titleController.text));
    http.Response response1 = await http.post(
      Uri.parse('http://192.168.100.12:7000/chat/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, //'id','sender','message_me','receiver','time'
      body: jsonEncode(<String, String>{
        //'id': titleController.text,this is an autofield
        'name': 'Groupbuy', //groupbuy
        'sender': sender, //widget.me.toString(), //you
        'message_me':
            message_me, //'${amount2.toString()}', //ie '2/rono|re|amount|3
        'receiver': receiver,
        //widget.user.split('|')[0].split('/')[1].toString(), //parent user
        'time': time
        //now.toString() + '|' + leo.toString(),
      }),
    );
    //print(jsonDecode(response1.data.toString()) );
    //works => print(token['token']);

    if (response1.statusCode == 201) {
      print("yea it happened");
      print(jsonDecode(response1.body.toString()));
    }
  }

  void decrease(String i) {
    final prev = ii;
    ii = i;
    if (prev != ii) {
      quantity = 1;
    }
    quantity--;
  }

  String ii = '1';

  @override
  void initState() {
    super.initState();
    getWeather();
    //var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
  }

  @override
  Widget build(BuildContext context) {
    String works = '';
    KeyboardVisibilityController().onChange.listen((event) {
      setState(() {
        softkey = event;
        if (softkey == true) {
          works = 'ollo';
        }
        ;
      });

      print("THE KEYBOARD" + softkey.toString());
    });

    num sum = 0;
    for (num e in amount) {
      sum += e;
      print(sum);
      //sumx = sum;
    }

    //final sum = amount.sum;
    return sky != null
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
                length: sky['menu'][0]['menu'].length,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    flexibleSpace: new ClipRect(
                        child: new BackdropFilter(
                            filter: new ImageFilter.blur(
                                sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .23,
                              decoration: BoxDecoration(
                                //color: Colors.transparent,

                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.white,
                                    Colors.white,
                                    Colors.yellow.shade50,
                                    Colors.yellow.shade50,
                                    Colors.yellow.shade100,
                                    Colors.yellow.shade200
                                  ],
                                ),
                                //color:Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(
                                        10.0) //                 <--- border radius here
                                    ),
                              ),
                              //height: 200,
                              width: MediaQuery.of(context).size.width,
                              //
                            ))),
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    //centerTitle:true,

                    bottom: TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                                20.0) //                 <--- border radius here
                            ),
                        //color: Color.fromRGBO(27, 189, 198, 1),
                      ),
                      indicatorColor: Colors.green,
                      unselectedLabelColor: Colors.grey[900],
                      labelColor: Colors.amber,
                      tabs: [
                        ...sky['menu'][0]['menu'].map((i) => Tab(
                            icon: Text(i['name'].toString(),
                                style: TextStyle(
                                    backgroundColor: Colors.transparent)))),
                      ],
                    ),
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Chip(
                              avatar: Icon(
                                //widget.user.split('|').contains('|') ? Icons.group_outlined  &&
                                widget.user.toString() == 'Menu'
                                    ? Icons.storefront
                                    : widget.user.split('|').length > 1
                                        ? Icons.group_outlined
                                        : Icons.qr_code_scanner,
                                color: Colors.red,
                              ),
                              label: Text(
                                  widget.user.split('|').length > 1
                                      ? widget.user.split('|')[1].toString()
                                      : widget.user.toString(),
                                  style: TextStyle(color: Colors.black)))
                        ]),
                    actions: [
                      InkWell(
                          child: null, //c
                          onTap: () {}),
                      SizedBox(
                        width: 10,
                      )
                    ],

                    /* FloatingActionButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>trakstar(title:cart2),
                        ),
                      );
               /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>trak(title:cart,title2:quantity.toString()),
                        ),
                      );*/
              },
              backgroundColor: Colors.white,
              elevation: 0.0,
              mini: true,
              child: Center(
                  child: Stack(children: [
                Icon(Icons.receipt, color: Colors.red),
                Positioned(
                    top: 0,
                    right: 1,
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        radius: 6,
                      ),
                    ))
              ])),
            )*/

                    /*FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.white,
                            elevation: 0.0,
                            child: Center(
                                child: Stack(children: [
                              Icon(Icons.search, color: Colors.blueGrey[900]),
                            ])),
                            onPressed: () {
                              //search starts here
                              //print(title.toList());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => searchQ(
                                          misearch: sky['menu'][0]['menu'],
                                          username: widget.me,
                                          token: widget.token.toString(),
                                        )),
                              );
                            }),*/
                  ),
                  bottomNavigationBar: widget.user.split('|').length < 2
                      ? Chip(
                          backgroundColor: Colors.white,
                          avatar: Icon(Icons.location_pin),
                          label: Text(sky['username'].toString()))
                      : Text(''),
                  /*Chip(
                          backgroundColor: Colors.white,
                          avatar: Icon(Icons.wallet_giftcard),
                          label: Text(widget.user.split('|')[2].toString())),*/
                  body: TabBarView(
                    children: [
                      ...sky['menu'][0]['menu'].map((i) =>
                          SingleChildScrollView(
                              child: Column(children: [
                            ...i['food'].map((i) => Card(
                                color: !amount3.contains(i)
                                    ? Colors.white
                                    : Colors.white,
                                elevation: 0.4,
                                child: Column(children: [
                                  ListTile(
                                    leading: InkWell(
                                        child: Container(
                                          height: 80,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    10.0) //                 <--- border radius here
                                                ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  i['image_url'].toString()),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child:
                                              null /* add child content here */,
                                        ),
                                        onTap: () {}),
                                    title: Text(i['name'].toString()),
                                    //subtitle:
                                    trailing: InkWell(
                                        child: Chip(
                                            avatar: Icon(
                                                !amount3.contains(i)
                                                    ? Icons
                                                        .shopping_cart_outlined
                                                    : Icons.cloud_done_outlined,
                                                color: amount3.contains(i)
                                                    ? Colors.green
                                                    : Colors.green),
                                            label: Text(amount3.contains(i)
                                                ? 'Added'
                                                : 'Add'),
                                            backgroundColor: amount3.contains(i)
                                                ? Colors.white
                                                : Colors.yellow
                                                    .withOpacity(0.2)),
                                        onTap: () {
                                          //order1
                                          //

                                          amount3.contains(i)
                                              ? ''
                                              : setState(() {
                                                  //prev
                                                  final prev = ii;
                                                  if (prev == '1') {
                                                    quantity = 1;
                                                  }
                                                  ;
                                                  cart.add([
                                                    i,
                                                    quantity == null
                                                        ? 1
                                                        : quantity
                                                  ]);
                                                  //i.remove(i['image_url']);

                                                  amount2.add([
                                                    i['name'],
                                                    quantity,
                                                    (int.parse(i['price']) *
                                                        (quantity))
                                                  ]);
                                                  amount3.add(i);
                                                  print("here's the " +
                                                      amount3.toString());

                                                  amount.add(
                                                      (int.parse(i['price']) *
                                                          (quantity)));

                                                  quantity = 1;
                                                });

                                          //_total(int.parse(i['price'])*int.parse(quantity));

                                          //print(quantity.toString());
                                          //print('Summenu'+(int.parse(i[0]['price'])*int.parse(quantity)).toString());
                                          //print(int.parse(i['price'])*quantity);

                                          //here set the state of the boolean
                                          //_increase(i['name']);

                                          SetState() {
                                            //amount.add();

                                            print(cart.length);
                                            final quantity = 1;
                                            i['price'] =
                                                (int.parse(i['price']) *
                                                        (quantity))
                                                    .toString();
                                            print('amount' + amount.toString());
                                            print(i[0].toString());
                                          }

                                          ;
                                        }),
                                  ),
                                  ListTile(
                                      //leading:,Row(children:[ CircleAvatar(child:Icon(Icons.shopping_bag,color:Colors.green),radius:15,backgroundColor:Colors.grey[200])
                                      //    ,Text('1')])
                                      //trailing: Text(ii == i['name']?(int.parse(i['price'])*quantity).toString()+'/=':i['price'].toString()+'/=',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold)),

                                      //subtitle: Text(i['price'].toString()),
                                      title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                        Text(
                                            ii == i['name']
                                                ? (int.parse(i['price']) *
                                                            quantity)
                                                        .toString() +
                                                    '/='
                                                : i['price'].toString() + '/=',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        amount3.contains(i)
                                            ? Container()
                                            : Container(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        child: InkWell(
                                                            child: CircleAvatar(
                                                                child: Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .green),
                                                                radius: 15,
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        200]),
                                                            onTap: () {
                                                              print(i['name']);
                                                              setState(() {
                                                                cart.contains(i[
                                                                        'name'])
                                                                    ? Container()
                                                                    : _increase(
                                                                        i['name']);
                                                                print(cart);
                                                              });
                                                              print(quantity);
                                                            }),
                                                      ),
                                                      Text('\t'),
                                                      Text(ii == i['name']
                                                          ? quantity.toString()
                                                          : '1'),
                                                      Text('\t'),
                                                      InkWell(
                                                          child: CircleAvatar(
                                                              child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .green),
                                                              radius: 15,
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      200]),
                                                          onTap: () {
                                                            //print(i['name']);
                                                            setState(() {
                                                              if (quantity >
                                                                  1) {
                                                                decrease(
                                                                    i['name']);
                                                              }
                                                            });
                                                            print(quantity);
                                                          }),
                                                    ]),
                                              )
                                      ])),
                                ])

                                //end
                                ))
                          ]))),
                    ],
                  ),
                  floatingActionButton: cart.length > 0
                      ? FloatingActionButton(
                          onPressed: () {
                            showModalBottomSheet(
                                //isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder: (BuildContext
                                          context,
                                      StateSetter
                                          setState /*You can rename this!*/) {
                                    return Scaffold(
                                      backgroundColor: Colors.white,
                                      appBar: AppBar(
                                          centerTitle: true,
                                          title: Text("Cart",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          elevation: 0.0,
                                          backgroundColor: Colors.white),
                                      body: SingleChildScrollView(
                                          child: Column(
                                        children: [
                                          Text(
                                              "You're planning to order this foods/drinks"),
                                          ...cart.map(
                                            //title:cart,title2:quantity.toString(),title3:amount
                                            (i) => ListTile(
                                              leading: InkWell(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      amount3.remove(i);
                                                      cart.remove(i);
                                                      amount2.remove(i);
                                                      amount2 = amount2;

                                                      amount.remove((int.parse(
                                                              i[0]['price']) *
                                                          int.parse(i[1]
                                                              .toString())));
                                                      Navigator.pop(context);
                                                    });
                                                  }),
                                              title: Text(i[0]['name'],
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              subtitle:
                                                  Text(i[1].toString()), //
                                              trailing: Chip(
                                                  backgroundColor:
                                                      Colors.yellow,
                                                  label: Text(
                                                      (int.parse(i[0]['price']) *
                                                                  int.parse(i[1]
                                                                      .toString()))
                                                              .toString() +
                                                          '\t' +
                                                          "KES",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold))),
                                            ),
                                            //amount.add((int.parse(i[0]['price'])*int.parse(i[1].toString())))
                                          )
                                        ],
                                      )),
                                      //bottoma navigation bar
                                      bottomNavigationBar: ListTile(
                                        title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                            ]),
                                        subtitle: FloatingActionButton.extended(
                                            backgroundColor: Colors.green,
                                            //icon: Icon(Icons.flatware_outlined),
                                            label: Text("Order"),
                                            onPressed: () {
                                              startCheckout(
                                                  userPhone: "254705412626",
                                                  amount: sum
                                                      .toDouble()); //sum.toDouble()
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    //sum = 0;
                                                    //var given_list = [1, 2, 3, 4, 5];
                                                    //this was once an issue it made the sum double
                                                    /*for (var i = 0; i < amount.length; i++) {
      sum += amount[i];
      };*/
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.white,
                                                      appBar: AppBar(
                                                          centerTitle: true,
                                                          title: Text(
                                                              "Your Order",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          elevation: 0.0,
                                                          backgroundColor:
                                                              Colors.white),
                                                      body:
                                                          SingleChildScrollView(
                                                              child: Column(
                                                        children: [
                                                          Text(
                                                              "Your total is $sum KES",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      28)),
                                                          Text(""),
                                                          ListTile(
                                                              title: Text("")),
                                                          works == ''
                                                              ? Text(
                                                                  "initializing payments")
                                                              : Text("Confirm"),
                                                          ListTile(
                                                              title: Text("")),
                                                          works == ''
                                                              ? Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                )
                                                              : ListTile(
                                                                  title: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                                      ]),
                                                                  //does not work trailing: Icon(Icons.arrow_circle_left_outlined),
                                                                  subtitle: !softkey
                                                                      ? FloatingActionButton.extended(
                                                                          backgroundColor: Colors.teal,
                                                                          //icon: Icon(Icons.flatware_outlined),
                                                                          label: Text(//Container(child: CircularProgressIndicator()):
                                                                              'confirm Order'),
                                                                          //    icon: Icon(Icons.arrow_circle_left_outlined),
                                                                          onPressed: () {
                                                                            print("${selectedTime.hour}:${selectedTime.minute + 10}");

                                                                            widget.user.toString() == 'Menu'
                                                                                ? showModalBottomSheet(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return Scaffold();
                                                                                    })
                                                                                : '';
                                                                            widget.user.split('|').length < 2
                                                                                ? addata(widget.user.toString() == 'Menu' ? "Timed preorder" : "Summoning Waiter", '$sum', "${selectedTime.hour}:${selectedTime.minute}", 'ordername2')
                                                                                : createAlbumx(
                                                                                    '${widget.me.toString() + '|' + widget.user.toString() + '|' + sum.toString()}',
                                                                                    '${amount2.toString()}',
                                                                                    widget.user.split('|')[0].toString(), //,//widget.user.split('|')[0].split('/')[1].toString(),
                                                                                    leo.toString());
                                                                            Navigator.pop(context);
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => widget.user.toString() == 'Menu' ? screenxc2(title: "${selectedTime.hour}:${selectedTime.minute}") : screenxc2(title: "${selectedTime.hour}:${selectedTime.minute}")));
                                                                            //Navigator.pop(context);
                                                                            //Navigator.pop(context);
                                                                            cart.clear();
                                                                            setState(() {
                                                                              cart.length = 0;
                                                                              amount = [];
                                                                            });
                                                                          })
                                                                      : Container(width: 20)),
                                                          Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                //*/
                                                                SizedBox(
                                                                    height: 20),

                                                                SizedBox(
                                                                    height: 10),
                                                                ListTile(
                                                                    title: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                                        ]),
                                                                    subtitle: FloatingActionButton.extended(
                                                                        backgroundColor: Colors.redAccent,
                                                                        //icon: Icon(Icons.flatware_outlined),
                                                                        label: Text(widget.user.toString() == 'Menu' ? "Cancel" : "Cancel"),
                                                                        onPressed: () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.pop(
                                                                              context);
                                                                        }))

                                                                /*ListTile(
                                                                          title: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.end,
                                                                              children: [
                                                                                /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                                              ]),
                                                                          subtitle: FloatingActionButton.extended(
                                                                              backgroundColor: Colors.yellow[700],
                                                                              //icon: Icon(Icons.flatware_outlined),
                                                                              label: Text(widget.user.toString() == 'Menu' ? "set time for order" : "Other"),
                                                                              onPressed: () {
                                                                                sum =
                                                                                    0;
                                                                                for (var i = 0;
                                                                                    i < amount.length;
                                                                                    i++) {
                                                                                  sum += amount[i];
                                                                                }
                                                                                ;
                                                                                _selectTime(BuildContext context) async {
                                                                                  final timeOfDay = await showTimePicker(
                                                                                    context: context,
                                                                                    initialTime: selectedTime,
                                                                                    initialEntryMode: TimePickerEntryMode.dial,
                                                                                  );
                                                                                  if (timeOfDay != null && timeOfDay != selectedTime) {
                                                                                    //setState(() {
                                                                                    selectedTime = timeOfDay;
                                                                                  }
                                                                                }

                                                                                ;
                                                                                _selectTime(context);
                                                                                print("${selectedTime.hour}:${selectedTime.minute + 10}");

                                                                                //timed order
                                                                              }))*/
                                                              ]),
                                                        ],
                                                      )),
                                                      //bottoma navigation bar
                                                    );
                                                  });
                                              /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>trakstar(title:cart2),
                            ),
                          );*/
                                            } //scanQR(),

                                            // This trailing comma makes auto-formatting nicer for build methods.
                                            ),
                                      ),
                                    );
                                  });
                                });
                            /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>trak(title:cart,title2:quantity.toString(),title3:amount),
                        ),
                      );*/
                          },
                          backgroundColor: Colors.green,
                          elevation: 0.0,
                          //mini: true,
                          child: Center(
                              child: Stack(clipBehavior: Clip.none, children: [
                            Icon(Icons.shopping_cart_outlined,
                                color: Colors.yellow),
                            Positioned(
                                top: -3,
                                right: -4,
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 6,
                                    child: Center(
                                        child: Text(cart.length.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)) //cartfav
                                        ),
                                  ),
                                ))
                          ])),
                        )
                      : Container(),
                )),
          )
        : Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ])));
  }
}
