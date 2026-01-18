import 'package:flutter/material.dart';
import 'package:take_home_assessment/models/market_data_model.dart';
import 'package:take_home_assessment/shared/widgets/statics_tile_item.dart';
import 'package:take_home_assessment/utils/constants.dart';

class MarketDataDetailsScreen extends StatelessWidget {
  final MarketDataModel item;

  const MarketDataDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Price Section
          Text(
            item.symbol,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Text(
            "\$${item.price.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: item.color,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                item.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: item.color,
                size: 20,
              ),
              Text(
                " ${item.changePercent24h}% (24h)",
                style: TextStyle(
                  color: item.color,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Last Update :${item.formattedDate}',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),

          // Description Section
          const Text(
            "About",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.description ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 30),

          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: [
              StaticsTileItem(label: "24h High", value: "\$${item.high24h}"),
              StaticsTileItem(label: "24h Low", value: "\$${item.low24h}"),
              StaticsTileItem(
                label: "Market Cap",
                value: "\$${((item.marketCap ?? 0) / 1e9).toStringAsFixed(2)}B",
              ),
              StaticsTileItem(
                label: "Volume",
                value: "\$${(item.volume / 1e6).toStringAsFixed(2)}M",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
