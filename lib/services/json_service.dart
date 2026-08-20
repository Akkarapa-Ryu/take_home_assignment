import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/trader.dart';

class JsonService {
  Future<List<Trader>> loadTraders() async {
    final jsonString =
        await rootBundle.loadString('assets/raw_data.json');

    final jsonData = jsonDecode(jsonString) as List<dynamic>;

    return jsonData
      .map(
        (json) => Trader.fromJson(
          json as Map<String, dynamic>,
          ),
      )
      .toList();
  }
}