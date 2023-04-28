import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'price_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  String cryptoExchangeRate = '?';
  Map<String, String> cryptoToPrice = {};
  bool isPriceReady = false;

  @override
  initState() {
    super.initState();
    getExchangeRate();
  }

  List<PriceCard> getCryptoList() {
    List<PriceCard> priceCardList = [];
    for (String currency in cryptoList) {
      PriceCard priceCard = PriceCard(
        cryptoCurrency: currency,
        selectedCurrency: selectedCurrency,
        // if prices are ready then get the value of the correspoding crypto currency in the cryptoToprice map
        // and if the value if null, replace it with a question mark '?'
        cryptoExchangeRate: isPriceReady ? cryptoToPrice[currency] ?? '?' : '?',
      );
      priceCardList.add(priceCard);
    }
    return priceCardList;
  }

  Widget androidDropDown() {
    List<DropdownMenuItem> dropDownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getExchangeRate();
        });
      },
    );
  }

  Widget iOsPicker() {
    List<Widget> scrollItems = [];
    for (String currency in currenciesList) {
      Widget item = Text(currency);
      scrollItems.add(item);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedItemIndex) {
        print(selectedItemIndex);
      },
      children: scrollItems,
    );
  }

  getExchangeRate() async {
    try {
      print("################################################s");
      Map<String, String> data = await price.getPrices(selectedCurrency);
      isPriceReady = true;
      setState(() {
        cryptoToPrice = data;
      });
      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&7");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            children: getCryptoList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOsPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
