import 'package:doviz_app/models/currency_model.dart';
import 'package:doviz_app/services/exchange_services.dart';
import 'package:flutter/material.dart';

class ExchangeProvider with ChangeNotifier {
  List<Currency> currencies = [];
  String exchangeAmount = "0";
  double rate = 0;
  double resultAmount = 0;
  String baseCurrencyCode = "USD";
  String baseCurrencyDesc = "US Dollar";
  String toCurrencyCode = "TRY";
  String toCurrencyDesc = "Turkish Lira";

  ExchangeServices exchangeServices = ExchangeServices();

  Future getCurrencies() async {
    currencies = await exchangeServices.getCurrencies("symbols");
    notifyListeners();
  }

  Future getResult(String to, base, amount) async {
    resultAmount =
        await exchangeServices.getResult("convert", base, to, amount);
    notifyListeners();
  }

  Future getRate(String to, base) async {
    rate = 
        await exchangeServices.getRate("latest", base, to);
    notifyListeners();
  }

  setBaseCurrency(String code, desc) {
    baseCurrencyCode = code;
    baseCurrencyDesc = desc;
    notifyListeners();
  }

  setToCurrency(String code, desc) {
    toCurrencyCode = code;
    toCurrencyDesc = desc;
    notifyListeners();
  }

  setExchangeAmount(String i) {
    exchangeAmount += i;
    notifyListeners();
  }

  setExchangeAmountZero() {
    exchangeAmount = "0";
    notifyListeners();
  }

  deleteLastDigit() {
    exchangeAmount = exchangeAmount.substring(0, exchangeAmount.length - 1);
    notifyListeners();
  }
}
