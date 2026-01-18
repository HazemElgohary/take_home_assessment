import 'package:get_it/get_it.dart';
import 'package:take_home_assessment/services/api_service.dart';
import 'package:take_home_assessment/utils/constants.dart';
import 'package:take_home_assessment/utils/network/http_api_client.dart';

import '../providers/market_data_provider.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register the HTTP client
  getIt.registerLazySingleton<HttpApiClient>(
    () => HttpApiClient(baseUrl: AppConstants.baseUrl),
  );

  // Register MarketService
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(apiClient: getIt<HttpApiClient>()),
  );

  // Providers
  getIt.registerFactory<MarketDataProvider>(
    () => MarketDataProvider(getIt<ApiService>()),
  );
}
