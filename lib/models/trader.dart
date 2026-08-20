import 'package:json_annotation/json_annotation.dart';

part 'trader.g.dart';

@JsonSerializable()
class Trader {
  final String id;
  final String name;
  final String avatarUrl;
  final int copierCount;
  final int copierLimit;
  final bool isAPI;
  final List<String> tags;
  final double? pnl30d;
  final double? roi30d;
  final double? aum;
  final double? mdd30d;
  final double? shareRation;

  Trader ({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.copierCount,
    required this.copierLimit,
    required this.isAPI,
    required this.tags,
    this.pnl30d,
    this.roi30d,
    this.aum,
    this.mdd30d,
    this.shareRation,
  });

  factory Trader.fromJson(Map<String, dynamic> json) => _$TraderFromJson(json);

  Map<String, dynamic> toJson() => _$TraderToJson(this);
}