// TODO: Create MarketData model class
// Required fields:
// - symbol (String)
// - price (double)
// - change24h (double)
// - changePercent24h (double)
// - volume (double)
//
// Add a factory constructor fromJson that parses the JSON response
// Example JSON structure from API:
// {
//   "symbol": "BTC/USD",
//   "price": 43250.50,
//   "change24h": 2.5,
//   "changePercent24h": 2.5,
//   "volume": 1250000000
// }

import 'package:equatable/equatable.dart';

class MarketDataModel extends Equatable {
  final String symbol;
  final String? description;
  final double price;
  final double change24h;
  final double changePercent24h;
  final num volume;

  const MarketDataModel({
    required this.symbol,
    required this.price,
    required this.change24h,
    required this.changePercent24h,
    required this.volume,
    this.description,
  });

  factory MarketDataModel.fromJson(Map<String, dynamic> json) {
    return MarketDataModel(
      symbol: json['symbol'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0.0,
      change24h: json['change24h'] ?? 0,
      changePercent24h: json['changePercent24h'] ?? 0,
      volume: json['volume'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'description': description,
      'price': price,
      'change24h': change24h,
      'changePercent24h': changePercent24h,
      'volume': volume,
    };
  }

  @override
  List<Object?> get props => [
    symbol,
    description,
    price,
    change24h,
    changePercent24h,
    volume,
  ];
}
