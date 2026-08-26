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

  bool get hasFilter {
    return tags.isNotEmpty ||
        minPnl > 0 ||
        maxPnl < 500000 ||
        minRoi != null ||
        apiOnly;
  }
}