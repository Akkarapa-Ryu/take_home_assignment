// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trader.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trader _$TraderFromJson(Map<String, dynamic> json) => Trader(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      copierCount: (json['copierCount'] as num).toInt(),
      copierLimit: (json['copierLimit'] as num).toInt(),
      isAPI: json['isAPI'] as bool,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      pnl30d: (json['pnl30d'] as num?)?.toDouble(),
      roi30d: (json['roi30d'] as num?)?.toDouble(),
      aum: (json['aum'] as num?)?.toDouble(),
      mdd30d: (json['mdd30d'] as num?)?.toDouble(),
      shareRation: (json['shareRation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TraderToJson(Trader instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'copierCount': instance.copierCount,
      'copierLimit': instance.copierLimit,
      'isAPI': instance.isAPI,
      'tags': instance.tags,
      'pnl30d': instance.pnl30d,
      'roi30d': instance.roi30d,
      'aum': instance.aum,
      'mdd30d': instance.mdd30d,
      'shareRation': instance.shareRation,
    };
