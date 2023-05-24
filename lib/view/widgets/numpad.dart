import 'package:doviz_app/providers/exchange_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumpadWidget extends StatelessWidget {
  const NumpadWidget({super.key, required this.index, required this.buttons});
  final int index;
  final List<String> buttons;
  @override
  Widget build(BuildContext context) {
    ExchangeProvider exchangeProvider = Provider.of<ExchangeProvider>(context);
    return GestureDetector(
      onTap: () async {
        if (exchangeProvider.exchangeAmount.length < 10 ||
            buttons[index] == "C" ||
            buttons[index] == "DEL" ||
            buttons[index] == "Calc") {
          switch (buttons[index]) {
            case "C":
              exchangeProvider.setExchangeAmountZero();
              break;
            case "DEL":
              if (exchangeProvider.exchangeAmount.isNotEmpty) {
                exchangeProvider.deleteLastDigit();
                if (exchangeProvider.exchangeAmount.isEmpty) {
                  exchangeProvider.setExchangeAmountZero();
                }
              }
              break;
            case "Calc":
              exchangeProvider.getResult(
                  exchangeProvider.toCurrencyCode,
                  exchangeProvider.baseCurrencyCode,
                  exchangeProvider.exchangeAmount);
              break;
            default:
              if (exchangeProvider.exchangeAmount[0] == "0") {
                exchangeProvider.deleteLastDigit();
              }
              exchangeProvider.setExchangeAmount(buttons[index]);
          }
        }
      },
      child: Container(
        height: 85,
        width: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: index == 11 ? Colors.orange : Colors.black,
        ),
        child: Center(
          child: Text(
            buttons[index],
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
