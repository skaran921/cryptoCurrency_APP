import 'package:crypto_currency/models/coin_model.dart';

abstract class BaseCryptoRepository {
  Future<List<Coin>> getTopCoins({int pages});
  void dispose();
}
