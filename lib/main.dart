import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_converter/core/app/app.dart';
import 'package:money_converter/core/di/dp_injection.dart';
import 'package:money_converter/core/localization/app_localizations.dart';

void main() async {
  // Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await DpInjection.init();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalizations.supportedLocales,
      path: AppLocalizations.path,
      fallbackLocale: AppLocalizations.fallbackLocale,
      startLocale: AppLocalizations.startLocale,
      child: const App(),
    ),
  );
}
