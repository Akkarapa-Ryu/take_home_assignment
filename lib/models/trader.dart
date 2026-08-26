class Trader {
  final String id;
  final String name;
  final String avatarUrl;
  final int copierCount;
  final int copierLimit;
  final bool isAPI;
  final List<String> tags;
  final double pnl30d;
  final double roi30d;
  final double aum;
  final double mdd30d;
  final double sharpeRatio;
  // final int daysLeadingTrading;

  const Trader({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.copierCount,
    required this.copierLimit,
    required this.isAPI,
    required this.tags,
    required this.pnl30d,
    required this.roi30d,
    required this.aum,
    required this.mdd30d,
    required this.sharpeRatio,
    // required this.daysLeadingTrading,
  });

  factory Trader.fromJson(Map<String, dynamic> json) {
    return Trader(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      copierCount: (json['copierCount'] as num).toInt() ?? 0,
      copierLimit: (json['copierLimit'] as num).toInt() ?? 0,
      isAPI: json['isAPI'] as bool,
      tags: List<String>.from(json['tags'] ?? []),
      pnl30d: (json['pnl30d'] as num).toDouble() ?? 0,
      roi30d: (json['roi30d'] as num).toDouble() ?? 0,
      aum: (json['aum'] as num).toDouble() ?? 0,
      mdd30d: (json['mdd30d'] as num).toDouble() ?? 0,
      sharpeRatio: (json['sharpeRatio'] as num).toDouble(),
      // daysLeadingTrading: (json['daysLeadingTrading'] as num).toInt(),
    );
  }
}