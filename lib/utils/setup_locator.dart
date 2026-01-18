import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_home_assessment/providers/theme_provider.dart';
import 'package:take_home_assessment/services/api_service.dart';
import 'package:take_home_assessment/utils/constants.dart';
import 'package:take_home_assessment/utils/network/http_api_client.dart';

import '../providers/market_data_provider.dart';
import '../services/offline/offline_market_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Register ThemeProvider
  getIt.registerLazySingleton<ThemeProvider>(() => ThemeProvider());

  // Register the HTTP client
  getIt.registerLazySingleton<HttpApiClient>(
    () => HttpApiClient(baseUrl: AppConstants.baseUrl),
  );
  // Register OfflineMarketService
  getIt.registerLazySingleton<OfflineMarketService>(
    () => OfflineMarketService(),
  );

  // Register MarketService
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(apiClient: getIt<HttpApiClient>()),
  );

  // Providers
  getIt.registerFactory<MarketDataProvider>(
    () =>
        MarketDataProvider(getIt<ApiService>(), getIt<OfflineMarketService>()),
  );
}
