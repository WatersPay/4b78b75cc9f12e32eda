import 'package:json_annotation/json_annotation.dart';

part 'treasuryTipData.g.dart';

@JsonSerializable()
class TreasuryTipData extends _TreasuryTipData {
  static TreasuryTipData fromJson(Map<String, dynamic> json) =>
      _$TreasuryTipDataFromJson(json);
  Map<String, dynamic> toJson() => _$TreasuryTipDataToJson(this);
}

abstract class _TreasuryTipData {
  String? hash;
  String? reason;
  String? who;
  dynamic closes;
  String? finder;
  dynamic deposit;
  List<TreasuryTipItemData>? tips;
}

@JsonSerializable()
class TreasuryTipItemData extends _TreasuryTipItemData {
  static TreasuryTipItemData fromJson(Map<String, dynamic> json) =>
      _$TreasuryTipItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$TreasuryTipItemDataToJson(this);
}

abstract class _TreasuryTipItemData {
  String? address;
  dynamic value;
}
