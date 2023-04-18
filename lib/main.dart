import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vargikaran_web_app/login_screen.dart';
import 'package:vargikaran_web_app/starter/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
 // Locale? _locale;
  ValueNotifier<Locale> _locale = ValueNotifier(Locale('en'));

  setLocale(Locale locale) {
      _locale.value = locale;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: _locale,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'VargiKaran',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: value,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginScreen(), //HomePage(),
        );
      },
    );
  }
}
