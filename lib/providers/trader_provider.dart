import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/trader.dart';

final traderProvider =
    FutureProvider<List<Trader>>((ref) async {
  final jsonString =
      await rootBundle.loadString('assets/raw_data.json');

  final List<dynamic> jsonData =
      json.decode(jsonString);

  return jsonData
      .map((item) => Trader.fromJson(item))
      .toList();
});