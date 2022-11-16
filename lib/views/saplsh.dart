import 'package:flutter/material.dart';
import 'package:printdesignadmin/views/orders/orders.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    goToSignIn() {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Orders(),
            ));
      });
    }

    goToSignIn();
    return Scaffold(
        body: Center(
      child: Image.asset("lib/core/images/logo.png"),
    ));
  }
}
