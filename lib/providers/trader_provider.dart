import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/trader.dart';
import '../utils/trader_filter.dart';
import 'filter_provider.dart';

final traderProvider =
    FutureProvider<List<Trader>>((ref) async {
  final jsonString =
      await rootBundle.loadString('assets/raw_data.json');

  final List<dynamic> jsonData =
      json.decode(jsonString);

  return jsonData
      .map(
        (item) => Trader.fromJson(
          item as Map<String, dynamic>,
        ),
      )
      .toList();
});

final filteredTraderProvider =
    Provider<AsyncValue<List<Trader>>>((ref) {
  final tradersAsync = ref.watch(traderProvider);
  final filter = ref.watch(filterProvider);

  return tradersAsync.whenData(
    (traders) => applyFilter(
      traders,
      filter,
    ),
  );
});