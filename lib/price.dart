import 'package:http/http.dart' as http;
import 'dart:convert';
import 'coin_data.dart';

const apiKey = '99455ED4-E2E7-4BED-AFB1-05F7FCD0AD53';

class Price {
  Future getPrices(String SelectedFiatCurrency) async {
    Map<String, String> cryptoToPrice = {};
    for (String currency in cryptoList) {
      var url = Uri.https(
        "rest.coinapi.io",
        "v1/exchangerate/$currency/$SelectedFiatCurrency",
        {
          'apiKey': apiKey,
        },
      );
      var responses = await http.get(url);
      if (responses.statusCode == 200) {
        print("++++++++++++++++++++++++++++++++++++++++");
        var body = responses.body;
        var data = jsonDecode(body) as Map<String, dynamic>;
        String price = data['rate'].toStringAsFixed(2);
        cryptoToPrice[currency] = price;
      } else {
        print("---------------------------------");
        throw ("An error occured while making the request");
      }
    }
    print(cryptoToPrice);
    return cryptoToPrice;
  }
}
