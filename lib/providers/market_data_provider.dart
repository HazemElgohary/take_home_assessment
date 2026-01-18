import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:take_home_assessment/services/offline/offline_market_service.dart';
import '../services/api_service.dart';
import '../models/market_data_model.dart';

class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService;
  final OfflineMarketService _offlineMarketService;

  MarketDataProvider(this._apiService, this._offlineMarketService);

  final _marketData = <MarketDataModel>[];
  bool _isLoading = false;
  String? _error;

  List<MarketDataModel> get marketData => _marketData;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // TODO: Implement loadMarketData() method
  // This should:
  // 1. Set _isLoading = true and _error = null
  // 2. Call notifyListeners()
  // 3. Call _apiService.getMarketData()
  // 4. Convert the response to List<MarketData> using MarketData.fromJson
  // 5. Set _marketData with the result
  // 6. Handle errors by setting _error
  // 7. Set _isLoading = false
  // 8. Call notifyListeners() again

  Future<void> loadMarketData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _apiService.getMarketData();
      _marketData
        ..clear()
        ..addAll(data);
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCashedData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _offlineMarketService.getCashedMarketData();
      if (data.isEmpty) {
        loadMarketData();
      } else {
        _marketData
          ..clear()
          ..addAll(data);
      }
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
