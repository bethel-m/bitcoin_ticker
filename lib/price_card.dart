import 'package:flutter/material.dart';
import 'price.dart';

Price price = Price();

class PriceCard extends StatelessWidget {
  PriceCard({
    super.key,
    required this.cryptoExchangeRate,
    required this.cryptoCurrency,
    required this.selectedCurrency,
  });

  String cryptoExchangeRate;
  final String cryptoCurrency;
  String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $cryptoExchangeRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
