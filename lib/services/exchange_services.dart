import 'dart:convert';

import 'package:doviz_app/constants/constants.dart';
import 'package:doviz_app/models/currency_model.dart';
import 'package:http/http.dart' as http;

class ExchangeServices {
  Uri getUrl(String process, query) => Uri.parse("$baseUrl$process?$query");

  Future<List<Currency>> getCurrencies(String process) async {
    http.Response response = await http.get(
      getUrl(process, ""),
      // headers: {"apikey": apikey},
    );

    List<Currency> currencies = [];
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      for (var key in data["symbols"].keys) {
        Currency currency = Currency.fromMap(data["symbols"][key])..id = key;
        currencies.add(currency);
      }
      print(currencies.length);
    }
    return currencies;
  }

  Future<double> getResult(String process, base, to, amount) async {
    http.Response response =
        await http.get(getUrl(process, "from=$base&to=$to&amount=$amount"));

    var data = jsonDecode(response.body);
    return data["result"];
  }

  Future<double> getRate(String process, base, to) async {
    http.Response response = await http.get(getUrl(process, "base=$base"));

    var data = jsonDecode(response.body);

    return data["rates"][to];
  }
}
