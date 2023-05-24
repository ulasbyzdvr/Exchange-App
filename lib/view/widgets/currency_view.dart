import 'package:doviz_app/providers/exchange_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyView extends StatelessWidget {
  const CurrencyView(
      {super.key,
      required this.currencyName,
      required this.amount,
      required this.isBase});
  final String currencyName;
  final String amount;
  final bool isBase;

  @override
  Widget build(BuildContext context) {
    ExchangeProvider exchangeProvider = Provider.of<ExchangeProvider>(context);
    return Container(
      height: 150,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 55,
                                ),
                                const Text(
                                  "Select Currency",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: exchangeProvider.currencies.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (isBase == true) {
                                        exchangeProvider.setBaseCurrency(
                                            exchangeProvider
                                                .currencies[index].code!,
                                            exchangeProvider.currencies[index]
                                                .description!);
                                        exchangeProvider.getResult(
                                            exchangeProvider.toCurrencyCode,
                                            exchangeProvider.baseCurrencyCode,
                                            exchangeProvider.exchangeAmount);
                                        exchangeProvider.getRate(
                                            exchangeProvider.toCurrencyCode,
                                            exchangeProvider.baseCurrencyCode);
                                      } else {
                                        exchangeProvider.setToCurrency(
                                            exchangeProvider
                                                .currencies[index].code!,
                                            exchangeProvider.currencies[index]
                                                .description!);
                                        exchangeProvider.getResult(
                                            exchangeProvider.toCurrencyCode,
                                            exchangeProvider.baseCurrencyCode,
                                            exchangeProvider.exchangeAmount);
                                        exchangeProvider.getRate(
                                            exchangeProvider.toCurrencyCode,
                                            exchangeProvider.baseCurrencyCode);
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      height: 60,
                                      child: Text(
                                        "${exchangeProvider.currencies[index].description!} ${exchangeProvider.currencies[index].code!}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                "$currencyName >",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            if (isBase == false)
              Text(
                "~${exchangeProvider.rate.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
