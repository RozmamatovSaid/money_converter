import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  static Future<void> init() async {
    await EasyLocalization.ensureInitialized();
  }

  static const supportedLocales = SupportedLocales._locales;

  static const fallbackLocale = Locale('en', 'US');
  static const startLocale = Locale("en", "US");
  static const path = "assets/translations";
}

class SupportedLocales {
  static const List<Locale> _locales = [
    Locale("en", "US"),
    Locale("uz", "UZ"),
    Locale("ru", "RU"),
  ];
}
