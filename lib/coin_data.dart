import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String? currencyPicked = 'USD';
  String? bitcoinPicked = 'BTC';
  String? ETHPicked = 'ETH';
  String? LTCPicked = 'LTC';

  CoinData({required this.currencyPicked});

  Future<int?> getbitcoinCoinData() async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$bitcoinPicked/$currencyPicked?apikey=1B63FB42-1336-4A60-8482-C875CDBF0406'));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data)['rate'];
      int bitcoinrate = decodedData.toInt();
      return bitcoinrate;
    } else {
      print(response.statusCode);
    }
  }

  Future<int?> getETHCoinData() async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$ETHPicked/$currencyPicked?apikey=1B63FB42-1336-4A60-8482-C875CDBF0406'));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data)['rate'];
      int ETHrate = decodedData.toInt();
      return ETHrate;
    } else {
      print(response.statusCode);
    }
  }

  Future<int?> getLTCCoinData() async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$LTCPicked/$currencyPicked?apikey=1B63FB42-1336-4A60-8482-C875CDBF0406'));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data)['rate'];
      int LTCrate = decodedData.toInt();
      return LTCrate;
    } else {
      print(response.statusCode);
    }
  }
}
