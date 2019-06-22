import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './home_page.dart';
import 'dart:async' show json;
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
List currencies = await getCurrencies();
  runApp(new MyApp(currencies));
} 

class MyApp extends StatelessWidget{
  final List _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.green,
        primaryColor: defaultTargetPlatform == TargetPlatform.android ? Colors.grey[100] : null,
      ),
      title: "CryptoCurrency App",
      home: new HomePage(_currencies),
    );
  }

}

 Future<List> getCurrencies() async {
   String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
   http.Response response = await http.get(cryptoUrl);
   return json.decode(response.body);
 }