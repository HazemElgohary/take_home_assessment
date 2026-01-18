import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:take_home_assessment/models/market_data_model.dart';
import 'package:take_home_assessment/utils/exceptions/network_exception.dart';
import 'package:take_home_assessment/utils/prefs.dart';
import 'package:take_home_assessment/utils/prefs_keys.dart';
import '../utils/constants.dart';
import '../utils/network/http_api_client.dart';

class ApiService {
  final HttpApiClient apiClient;

  ApiService({required this.apiClient});

  // TODO: Implement getMarketData() method
  // This should call GET /api/market-data and return the response
  // Example:
  // Future<List<Map<String, dynamic>>> getMarketData() async {
  //   final response = await http.get(Uri.parse('$baseUrl/market-data'));
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     return List<Map<String, dynamic>>.from(jsonData['data']);
  //   } else {
  //     throw Exception('Failed to load market data: ${response.statusCode}');
  //   }
  // }

  Future<List<MarketDataModel>> getMarketData() async {
    final res = await apiClient.get(AppConstants.marketDataEndpoint);
    if (res.statusCode != 200) {
      throw NetworkException('Failed to load market data: ${res.statusCode}');
    }
    final decodedBody = jsonDecode(res.body) as Map<String, dynamic>;
    final data = (decodedBody['data'] as List<dynamic>)
        .map((e) => MarketDataModel.fromJson(e))
        .toList();

    // Cache data locally

    await Prefs.setString(
      PrefsKeys.marketDataKey,
      jsonEncode(data.map((e) => e.toMap()).toList()),
    );

    return data;
  }
}
