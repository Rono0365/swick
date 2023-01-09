import 'package:http/http.dart' as http;
import 'dart:convert';

Future GetData(String url) async {
  final response = await http.get(
    Uri.parse(url),
    
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("Works");
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}