import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:take_home_assessment/utils/constants.dart';

import '../../models/market_data_model.dart';

class MarketDataListItem extends StatelessWidget {
  final MarketDataModel data;
  final VoidCallback onTap;

  const MarketDataListItem({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final priceFormatted = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    ).format(data.price);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.symbol,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${data.volume} Volume',
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                      Text(
                        '${data.isPositive ? '+' : ''}${data.change24h.toStringAsFixed(2)} change24h',
                        style: TextStyle(fontSize: 12, color: data.color),
                      ),
                      Text(
                        '${data.isPositive ? '+' : ''}${data.changePercent24h.toStringAsFixed(2)} %',
                        style: TextStyle(fontSize: 12, color: data.color),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Price container
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: data.color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    priceFormatted,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
