import 'dart:convert';

import 'package:take_home_assessment/models/market_data_model.dart';
import 'package:take_home_assessment/utils/prefs.dart';
import 'package:take_home_assessment/utils/prefs_keys.dart';

class OfflineMarketService {
  Future<List<MarketDataModel>> getCashedMarketData() async {
    final cached = Prefs.getString(PrefsKeys.marketDataKey);
    if (cached.isEmpty) {
      return [];
    }

    final decodedListOfMap = jsonDecode(cached);

    return (decodedListOfMap as List)
        .map((e) => MarketDataModel.fromJson(e))
        .toList();
  }
}
