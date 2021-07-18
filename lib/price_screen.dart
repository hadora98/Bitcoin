import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'exchange_card.dart';
import 'dart:convert';
import 'dart:io' show Platform;
class PriceScreen extends StatefulWidget {

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency='USD';
  var rates=[];
  bool isWaiting=false;
  CoinData coinData;

  DropdownButton<String> getAndroidPicker(){
    List<DropdownMenuItem<String>> dropDownItems=[];
    for(String item in currenciesList){
      var menuItem=DropdownMenuItem(child: Text(item),
      value:item);
      dropDownItems.add(menuItem);
    }
    return DropdownButton<String>(
        value: currentCurrency,
        onChanged: (String newValue)  {
          setState(() {

            currentCurrency = newValue;
            calculateRate();




          });

        },
        items: dropDownItems
    );

  }
  CupertinoPicker getIOSPicker(){
    List<Text> dropDownItems=[];
    for(String item in currenciesList){
      var menuItem=Text(item);
      dropDownItems.add(menuItem);

    }
    return CupertinoPicker(
        itemExtent: 30.0,
        onSelectedItemChanged: (selectedIndex){
          setState(() async {
            currentCurrency = currenciesList[selectedIndex];
            calculateRate();

          });
        },
        children: dropDownItems
    );

  }

 void calculateRate() async {
   isWaiting=true;



   double rate1;
    coinData=CoinData();

    var cryptoData= await coinData.getCryptoData(currentCurrency);
    isWaiting=false;




    setState(() {

      rates=cryptoData;

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      calculateRate();


  }
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              ExchangeCard(text: "${cryptoList[0]} = ${isWaiting?'?':rates[0]}$currentCurrency",),
              ExchangeCard(text:"${cryptoList[1]} =  ${isWaiting?'?':rates[1]}$currentCurrency"),
              ExchangeCard(text: "${cryptoList[2]}=  ${isWaiting?'?':rates[2]}$currentCurrency",),

            ],
          ),


          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS?getIOSPicker():getAndroidPicker()
          ),
        ],
      ),
    );
  }
}


