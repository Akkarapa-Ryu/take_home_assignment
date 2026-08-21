import 'package:flutter_riverpod/flutter_riverpod.dart';

class TraderFilter {
  final List<String> tag;
  final double minPnl;
  final double maxPnl;
  final double? minRoi;
  final bool apiOnly;

  const TraderFilter({
    this.tag = const [],
    this.minPnl = 0,
    this.maxPnl = 500000,
    this.minRoi,
    this.apiOnly = false,
  });

  TraderFilter copyWith({
    List<String>? tag,
    double? minPnl,
    double? maxPnl,
    double? minRoi,
    bool? apiOnly,
  }) {
    return TraderFilter(
      tag: tag ?? this.tag,
      minPnl: minPnl ?? this.minPnl,
      maxPnl: maxPnl ?? this.maxPnl,
      minRoi: minRoi ?? this.minRoi,
      apiOnly: apiOnly ?? this.apiOnly,
    );
  }
}

const _unset = Object();

final filterProvider = NotifierProvider<FilterNotifier, TraderFilter>(FilterNotifier.new,);

class FilterNotifier extends Notifier<TraderFilter> {
  @override
  TraderFilter build() {
    return const TraderFilter();
  }

  void toggleTag(String tag) {
    final tags = [...?state.tag];
    if (tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }

    state = state.copyWith(tag: tags);
  }

    void setPnl(double min, double max) {
    state = state.copyWith(
      minPnl: min,
      maxPnl: max,
    );
  }

  void setRoi(double? roi) {
    state = state.copyWith(
      minRoi: roi,
    );
  }

  void setApi(bool value) {
    state = state.copyWith(
      apiOnly: value,
    );
  }

  void reset() {
    state = const TraderFilter();
  }
}

