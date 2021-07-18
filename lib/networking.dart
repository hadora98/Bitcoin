
import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper{
  final String url;
  NetworkHelper({this.url});



  Future getData() async {
    http.Response response=await http.get(Uri.parse(this.url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);



    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
    }
  }
}