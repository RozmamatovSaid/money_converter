import 'package:money_converter/features/main/domain/entity/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  const CurrencyModel({
    required super.id,
    required super.code,
    required super.ccy,
    required super.ccyNmRu,
    required super.ccyNmUz,
    required super.ccyNmUzc,
    required super.ccyNmEn,
    required super.nominal,
    required super.rate,
    required super.diff,
    required super.date,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'] ?? 0,
      code: json['Code'] ?? '',
      ccy: json['Ccy'] ?? '',
      ccyNmRu: json['CcyNm_RU'] ?? '',
      ccyNmUz: json['CcyNm_UZ'] ?? '',
      ccyNmUzc: json['CcyNm_UZC'] ?? '',
      ccyNmEn: json['CcyNm_EN'] ?? '',
      nominal: int.tryParse(json['Nominal'].toString()) ?? 1,
      rate: double.tryParse(json['Rate'].toString()) ?? 0,
      diff: double.tryParse(json['Diff'].toString()) ?? 0,
      date: json['Date'] ?? '',
    );
  }
}
