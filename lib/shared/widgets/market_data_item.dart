import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:take_home_assessment/utils/constants.dart';

import '../../models/market_data_model.dart';

class MarketDataListItem extends StatelessWidget {
  final MarketDataModel data;

  const MarketDataListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final priceColor = data.change24h >= 0
        ? const Color(AppConstants.positiveColor)
        : const Color(AppConstants.negativeColor);
    final priceFormatted = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    ).format(data.price);

    return Card(
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
                    '${data.change24h.toStringAsFixed(2)} change24h',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                  Text(
                    '${data.changePercent24h.toStringAsFixed(2)} changePercent24h',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Price container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: priceColor,
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
    );
  }
}
