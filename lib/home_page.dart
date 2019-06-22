import 'package:flutter/material.dart';
import 'dart:async' show json;
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  List currencies;
  HomePage(this.currencies);
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List currencies;
  final List<MaterialColor> _colors = [Colors.blue,Colors.red,Colors.teal];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CryptoCurrency App"),
      ),
      body: cryptoWidget(),
    );
  }

  Widget cryptoWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
           new Flexible(
          child: new ListView.builder(
            itemCount: widget.currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final Map currency = widget.currencies[index];
              final MaterialColor color = _colors[index % _colors.length];

              return _getListItemUI(currency,color);
            },
          ),
        ),
        ],
              
      ),
    );
  }

  ListTile _getListItemUI(Map currency,MaterialColor color){
    return new ListTile(
      leading: new CircleAvatar(backgroundColor: color,
      child: new Text(currency['name'][0]),
      ),
      title: new Text(currency['name'],style: new TextStyle(fontWeight: FontWeight.bold),),
      subtitle: _getSubtitleText(currency['price_usd'],currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD,String percentageChange){
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUSD\n",
    style: new TextStyle(color: Colors.blue),
    );
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if(double.parse(percentageChange) > 0){
      percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
      style: new TextStyle(color: Colors.green)
      
      );
    }else{
       percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
      style: new TextStyle(color: Colors.red)
      
      );
    }
    return new RichText(
      text: new TextSpan(
        children: [priceTextWidget,percentageChangeTextWidget]
      ),
    );
  }
}
