import 'package:flutter/foundation.dart';
import 'package:take_home_assessment/utils/setup_locator.dart';
import '../services/api_service.dart';

class PortfolioProvider with ChangeNotifier {
  final ApiService _apiService = getIt<ApiService>();

  Map<String, dynamic>? _summary;
  List<dynamic> _holdings = [];
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get summary => _summary;
  List<dynamic> get holdings => _holdings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // TODO: Implement methods
  // - loadPortfolioSummary()
  // - loadHoldings()
  // - loadPerformance(String timeframe)
  // - addTransaction(Map<String, dynamic> transaction)

  Future<void> loadPortfolioSummary() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement API call
      // final response = await _apiService.getPortfolioSummary();
      // _summary = response['data'];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
