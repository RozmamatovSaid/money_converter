import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  const CurrencyEntity({
    required this.id,
    required this.code,
    required this.ccy,
    required this.ccyNmRu,
    required this.ccyNmUz,
    required this.ccyNmUzc,
    required this.ccyNmEn,
    required this.nominal,
    required this.rate,
    required this.diff,
    required this.date,  
  });

  final int id;
  final String code;
  final String ccy;
  final String ccyNmRu;
  final String ccyNmUz;
  final String ccyNmUzc;
  final String ccyNmEn;
  final int nominal;
  final double rate;
  final double diff;
  final String date;

  @override
  List<Object?> get props => [
        id,
        code,
        ccy,
        ccyNmRu,
        ccyNmUz,
        ccyNmUzc,
        ccyNmEn,
        nominal,
        rate,
        diff,
        date,
      ];
}