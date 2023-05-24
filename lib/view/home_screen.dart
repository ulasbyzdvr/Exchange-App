import 'package:doviz_app/providers/exchange_provider.dart';
import 'package:doviz_app/view/widgets/currency_view.dart';
import 'package:doviz_app/view/widgets/numpad.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExchangeProvider exchangeProvider = Provider.of<ExchangeProvider>(context);
    List<String> buttons = [
      '7',
      '8',
      '9',
      'C',
      '4',
      '5',
      '6',
      'DEL',
      '1',
      '2',
      '3',
      'Calc',
      '00',
      '0',
      '.',
      'CALC',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Exchange Money",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CurrencyView(
                amount: exchangeProvider.exchangeAmount,
                currencyName:
                    "${exchangeProvider.baseCurrencyDesc} ${exchangeProvider.baseCurrencyCode}",
                isBase: true,
              ),
              GestureDetector(
                onTap: () {
                  String tmpBaseCode = exchangeProvider.baseCurrencyCode;
                  String tmpBaseDesc = exchangeProvider.baseCurrencyDesc;
                  String tmpToCode = exchangeProvider.toCurrencyCode;
                  String tmpToDesc = exchangeProvider.toCurrencyDesc;

                  exchangeProvider.setBaseCurrency(tmpToCode, tmpToDesc);
                  exchangeProvider.setToCurrency(tmpBaseCode, tmpBaseDesc);
                  exchangeProvider.getRate(exchangeProvider.toCurrencyCode,
                      exchangeProvider.baseCurrencyCode);

                  exchangeProvider.getResult(
                      exchangeProvider.toCurrencyCode,
                      exchangeProvider.baseCurrencyCode,
                      exchangeProvider.exchangeAmount);
                },
                child: const SizedBox(
                  height: 40,
                  child: Icon(
                    Icons.swap_vert,
                    size: 40,
                  ),
                ),
              ),
              CurrencyView(
                amount: exchangeProvider.resultAmount.toStringAsFixed(2),
                currencyName:
                    "${exchangeProvider.toCurrencyDesc} ${exchangeProvider.toCurrencyCode}",
                isBase: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return Center(
                      child: index == 15
                          ? const SizedBox()
                          : NumpadWidget(index: index, buttons: buttons),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
