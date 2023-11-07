import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform; // Platform is a class
import 'components.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  int? showbitcoinRateNumber = 0;
  int? showETHRateNumber = 0;
  int? showLTCRateNumber = 0;
  int iosSelectedIndex = 0;
  String? userCurrency = 'AUD';

  @override
  void initState() {
    super.initState();

    updateUI();
  }

  DropdownButton<dynamic> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    // for (String currency in currenciesList)
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];

      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<dynamic>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          userCurrency = value;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItems = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          iosSelectedIndex = selectedIndex;
          userCurrency = currenciesList[iosSelectedIndex];
          updateUI();
        });
      },
      children: pickerItems,
    );
  }

  Widget? getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    } else {
      return null;
    }
  }

  void updateUI() async {
    CoinData coindata = CoinData(currencyPicked: userCurrency);
    int? bitcoinrate = await coindata.getbitcoinCoinData();
    int? ETHrate = await coindata.getETHCoinData();
    int? LTCrate = await coindata.getLTCCoinData();
    setState(() {
      showbitcoinRateNumber = bitcoinrate;
      showETHRateNumber = ETHrate;
      showLTCRateNumber = LTCrate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: ReusableCard(
              crypto: 'BTC',
              finalCurrency: userCurrency,
              finalRate: showbitcoinRateNumber,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: ReusableCard(
              crypto: 'ETH',
              finalCurrency: userCurrency,
              finalRate: showETHRateNumber,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: ReusableCard(
              crypto: 'LTC',
              finalCurrency: userCurrency,
              finalRate: showLTCRateNumber,
            ),
          ),
          Spacer(),
          Container(
            height: 150.0,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
