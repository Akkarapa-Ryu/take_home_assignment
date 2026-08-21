import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trader.dart';
import '../services/json_service.dart';

final traderProvider = AsyncNotifierProvider<TraderNotifier, List<Trader>>(TraderNotifier.new,);

// AsyncNotifier เอาไว้โหลดข้อมูลที่ต้องใช้งาน
class TraderNotifier extends AsyncNotifier<List<Trader>> {
  @override
  Future<List<Trader>> build() async {
    final jsonService = JsonService();
    return jsonService.loadTraders();
  }
}