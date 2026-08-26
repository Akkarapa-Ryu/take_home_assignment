import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/trader.dart';
import '../utils/trader_filter.dart';

final filterProvider =
    NotifierProvider<FilterNotifier, TraderFilter>(
  FilterNotifier.new,
);

class FilterNotifier extends Notifier<TraderFilter> {
  @override
  TraderFilter build() {
    return const TraderFilter();
  }

  // =========================
  // Tags
  // =========================

  void toggleTag(String tag) {
    final currentTags = [...state.tags];

    if (currentTags.contains(tag)) {
      currentTags.remove(tag);
    } else {
      currentTags.add(tag);
    }

    state = state.copyWith(
      tags: currentTags,
    );
  }

  void setTags(List<String> tags) {
    state = state.copyWith(tags: [...tags]);
  }

  // =========================
  // PNL
  // =========================

  void setPnlRange(
    double min,
    double max,
  ) {
    state = state.copyWith(
      minPnl: min,
      maxPnl: max,
    );
  }

  // =========================
  // ROI
  // =========================

  void setMinRoi(double? roi) {
    if (roi == null) {
      state = state.copyWith(
        clearMinRoi: true,
      );
      return;
    }

    state = state.copyWith(
      minRoi: roi,
    );
  }

  // =========================
  // API
  // =========================

  void setApiOnly(bool value) {
    state = state.copyWith(
      apiOnly: value,
    );
  }

  // =========================
  // Reset
  // =========================

  void reset() {
    state = const TraderFilter();
  }

  // =========================
  // Apply
  // =========================

  List<Trader> apply(
    List<Trader> traders,
  ) {
    return applyFilter(
      traders,
      state,
    );
  }
}