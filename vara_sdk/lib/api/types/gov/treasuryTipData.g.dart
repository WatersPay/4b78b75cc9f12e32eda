// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treasuryTipData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreasuryTipData _$TreasuryTipDataFromJson(Map<String, dynamic> json) =>
    TreasuryTipData()
      ..hash = json['hash'] as String?
      ..reason = json['reason'] as String?
      ..who = json['who'] as String?
      ..closes = json['closes']
      ..finder = json['finder'] as String?
      ..deposit = json['deposit']
      ..tips = (json['tips'] as List<dynamic>?)
          ?.map((e) => TreasuryTipItemData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TreasuryTipDataToJson(TreasuryTipData instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'reason': instance.reason,
      'who': instance.who,
      'closes': instance.closes,
      'finder': instance.finder,
      'deposit': instance.deposit,
      'tips': instance.tips,
    };

TreasuryTipItemData _$TreasuryTipItemDataFromJson(Map<String, dynamic> json) =>
    TreasuryTipItemData()
      ..address = json['address'] as String?
      ..value = json['value'];

Map<String, dynamic> _$TreasuryTipItemDataToJson(
        TreasuryTipItemData instance) =>
    <String, dynamic>{
      'address': instance.address,
      'value': instance.value,
    };
