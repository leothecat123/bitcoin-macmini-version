import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  String? crypto = 'BTC';
  int? finalRate = 0;
  String? finalCurrency = 'USD';

  ReusableCard(
      {required this.crypto,
      required this.finalCurrency,
      required this.finalRate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $finalRate $finalCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
