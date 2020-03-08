import 'dart:convert';

import 'package:crypto_currency/models/coin_model.dart';
import 'package:crypto_currency/repositories/base_crypto_repo.dart';
import 'package:http/http.dart' as http;

class CryptoRepository extends BaseCryptoRepository {
  static const String _baseUrl = "https://min-api.cryptocompare.com";
  static const int _perPage = 20;

  final http.Client _httpClient;

  CryptoRepository(this._httpClient);
  @override
  Future<List<Coin>> getTopCoins({int pages}) async {
    List<Coin> coins = [];
    String requestUrl =
        "$_baseUrl/data/top/totalvolfull?limit=$_perPage&tsym=USD&page=$pages";

    try {
      final response = await _httpClient.get(requestUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> coinList = data['Data'];
        coinList.forEach((json) => coins.add(Coin.fromJson(json)));
      }
      return coins;
    } catch (err) {
      throw (err);
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
