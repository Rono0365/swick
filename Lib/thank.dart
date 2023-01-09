import 'package:flutter/material.dart';
import 'main.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';
import 'package:mpesa/mpesa.dart';


class screenxc extends StatefulWidget {
  const screenxc({Key? key}) : super(key: key);

  @override
  _screenxcState createState() => _screenxcState();
}

class _screenxcState extends State<screenxc> {
  void maixc() {
  final mpesa = Mpesa(
    clientKey: "rjDWHXkZ3RX5Gy4xDvNztA6ARJQo6gQx",
    clientSecret: "kL2L4KMvGhZDqIZn",
    passKey: "ZosKCrrAVoHvuvGtAF5CfG7sdSMI",
    environment: "sandbox",
  );

  mpesa
      .lipaNaMpesa(
        phoneNumber: "254705412626",
        amount: 1,
        businessShortCode: "174379",
        callbackUrl: "",
      )
      .then((result) {})
      .catchError((error) {});
}
  Future<void> startCheckout(
      ) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
         
          transactionType: TransactionType.CustomerPayBillOnline,
          amount:1.0,
          partyA: "254705412626",
          partyB: "174379",
          callBackURL:
              Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
          accountReference: "Swick",
          phoneNumber: "254705412626",
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "swickorder",
          passKey:
              'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

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

  @override
  void initState() {
    super.initState();
    //_navtohome();
    WidgetsFlutterBinding.ensureInitialized();
    //MobileAds.instance.initialize();

    MpesaFlutterPlugin.setConsumerKey('rjDWHXkZ3RX5Gy4xDvNztA6ARJQo6gQx');
    MpesaFlutterPlugin.setConsumerSecret('kL2L4KMvGhZDqIZn');
  }

  _navtohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    //Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0, centerTitle: true, title: Text('Mpesa Payment')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Till Number ...'),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              keyboardType: TextInputType.number,
              //controller: titleController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  //fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'PhoneNumber',
                  hintText: 'Enter your phonenumber'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.number,
              //controller: titleController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  //fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'pin',
                  hintText: 'Enter your Mpesa pin'),
            ),
          ),
          // Icon(Icons.check_circle_outline,size:70),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          FloatingActionButton.extended(
              backgroundColor: Colors.teal,
              //icon: Icon(Icons.flatware_outlined),
              label: Text("Continue"),
              //    icon: Icon(Icons.arrow_circle_left_outlined),
              onPressed: () {
               // setState(() {
                startCheckout();  
               
                
              })
          // Text("Thank You"+'\n'+"You'll receive your order in a few.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22), textAlign: TextAlign.center,),

          /*Container(
              height: MediaQuery.of(context).size.width * 0.45,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Image.asset('assets/play_store_512.png')),*/
        ],
      )),
      bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.width * 0.10,
          width: MediaQuery.of(context).size.width * 0.10,
          child: Text(
            "",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
    );
  }
}
