import '../models/trader.dart';

class TraderFilter {
  final List<String> tags;
  final double minPnl;
  final double maxPnl;
  final double? minRoi;
  final bool apiOnly;

  const TraderFilter({
    this.tags = const [],
    this.minPnl = 0,
    this.maxPnl = 500000,
    this.minRoi,
    this.apiOnly = false,
  });

  bool get hasActiveFilter {
    return tags.isNotEmpty ||
        minPnl != 0 ||
        maxPnl != 500000 ||
        minRoi != null ||
        apiOnly;
  }

  int get activeFilterCount {
    int count = 0;

    // แต่ละ Tag = 1
    count += tags.length;

    // PNL range = 1
    if (minPnl != 0 || maxPnl != 500000) {
      count++;
    }

    // ROI = 1
    if (minRoi != null) {
      count++;
    }

    // API = 1
    if (apiOnly) {
      count++;
    }

    return count;
  }

  TraderFilter copyWith({
    List<String>? tags,
    double? minPnl,
    double? maxPnl,
    double? minRoi,
    bool? apiOnly,
    bool clearMinRoi = false,
  }) {
    return TraderFilter(
      tags: tags ?? this.tags,
      minPnl: minPnl ?? this.minPnl,
      maxPnl: maxPnl ?? this.maxPnl,
      minRoi: clearMinRoi ? null : (minRoi ?? this.minRoi),
      apiOnly: apiOnly ?? this.apiOnly,
    );
  }

  bool get isDefault {
    return tags.isEmpty &&
        minPnl == 0 &&
        maxPnl == 500000 &&
        minRoi == null &&
        !apiOnly;
  }
}

List<Trader> applyFilter(
  List<Trader> traders,
  TraderFilter filter,
) {
  return traders.where((trader) {

    // =========================
    // Tags - AND
    // =========================
    if (filter.tags.isNotEmpty) {
      final hasAllTags = filter.tags.every(
        (selectedTag) => trader.tags.contains(selectedTag),
      );

      if (!hasAllTags) {
        return false;
      }
    }

    // =========================
    // PNL
    // =========================
    if (filter.minPnl != 0 || filter.maxPnl != 500000) {
      if (trader.pnl30d < filter.minPnl ||
          trader.pnl30d > filter.maxPnl) {
        return false;
      }
    }

    // =========================
    // ROI
    // =========================
    if (filter.minRoi != null &&
        trader.roi30d < filter.minRoi!) {
      return false;
    }

    // =========================
    // API
    // =========================
    if (filter.apiOnly && !trader.isAPI) {
      return false;
    }

    return true;
  }).toList();
}