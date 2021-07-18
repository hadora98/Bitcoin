import 'networking.dart';
const kApiKey='C26C4813-135A-4176-86F8-2D19A5BC6BA7';
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
  String coinDataURL='https://rest.coinapi.io/v1/exchangerate';
  Future getCryptoData(selectedCurrency) async{
    List cryptoData =[];

    for(String crypto in cryptoList){
      String url='$coinDataURL/$crypto/$selectedCurrency?apikey=$kApiKey';

      NetworkHelper net=NetworkHelper(url: url);
      var currentData=await net.getData();
      cryptoData.add(currentData['rate'].toStringAsFixed(0));

    }
    return cryptoData;




  }



}
