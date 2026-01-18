import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:take_home_assessment/shared/widgets/market_data_item.dart';
import '../providers/market_data_provider.dart';
import '../utils/setup_locator.dart';

class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  State<MarketDataScreen> createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  late final MarketDataProvider _provider;

  @override
  void initState() {
    super.initState();
    // TODO: Load market data when screen initializes
    // Provider.of<MarketDataProvider>(context, listen: false).loadMarketData();
    _provider = getIt<MarketDataProvider>();
    _provider.loadMarketData();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<MarketDataProvider>(
    //   builder: (context, provider, child) {
    //     // TODO: Implement the UI
    //     // Show loading indicator when provider.isLoading is true
    //     // Show error message when provider.error is not null
    //     // Show list of market data when provider.marketData is available
    //     // Each list item should show:
    //     //   - Symbol (e.g., "BTC/USD")
    //     //   - Price (formatted as currency)
    //     //   - 24h change (with color: green for positive, red for negative)
    //     // Implement pull-to-refresh using RefreshIndicator
    //
    //     if (provider.isLoading) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //
    //     if (provider.error != null) {
    //       return Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text('Error: ${provider.error}'),
    //             ElevatedButton(
    //               onPressed: () => provider.loadMarketData(),
    //               child: const Text('Retry'),
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //
    //     // TODO: Replace this placeholder with actual list implementation
    //     return const Center(
    //       child: Text('Market Data Screen - To be implemented'),
    //     );
    //   },
    // );

    return ChangeNotifierProvider<MarketDataProvider>.value(
      value: _provider,
      child: Consumer<MarketDataProvider>(
        builder: (context, provider, child) {
          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  ElevatedButton(
                    onPressed: () => provider.loadMarketData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: provider.loadMarketData,
            child: ListView.builder(
              itemCount: provider.isLoading ? 3 : provider.marketData.length,
              itemBuilder: (context, index) {
                if (provider.isLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        child: SizedBox(height: 100, width: double.infinity),
                      ),
                    ),
                  );
                } else {
                  final item = provider.marketData[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MarketDataListItem(data: item),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
