import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:doviz_app/providers/exchange_provider.dart';
import 'package:doviz_app/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AppInit extends StatelessWidget {
  const AppInit({super.key});
  @override
  Widget build(BuildContext context) {
    ExchangeProvider exchangeProvider = Provider.of<ExchangeProvider>(context);
    return AnimatedSplashScreen.withScreenFunction(
      splash: 'assets/logo.png',
      screenFunction: () async {
        await exchangeProvider.getCurrencies();
        await exchangeProvider.getRate(
            exchangeProvider.toCurrencyCode, exchangeProvider.baseCurrencyCode);
        print("currencies setted");
        return const HomeScreen();
      },
      splashIconSize: 200,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
