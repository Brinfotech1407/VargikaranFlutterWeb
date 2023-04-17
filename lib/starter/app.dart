// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:vargikaran_web_app/starter/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const _primaryColor = Color(0xFF6200EE);

class StarterApp extends StatelessWidget {
  const StarterApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'starter_app',
      title: AppLocalizations.of(context).helloWorld,
      debugShowCheckedModeBanner: false,
      //localizationsDelegates: GalleryLocalizations.localizationsDelegates,
      //supportedLocales: GalleryLocalizations.supportedLocales,
     // locale: GalleryOptions.of(context).locale,
      theme: ThemeData(
        highlightColor: Colors.transparent,
        colorScheme: const ColorScheme(
          primary: _primaryColor,
          primaryContainer: Color(0xFF3700B3),
          secondary: Color(0xFF03DAC6),
          secondaryContainer: Color(0xFF018786),
          background: Colors.white,
          surface: Colors.white,
          onBackground: Colors.black,
          error: Color(0xFFB00020),
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
        dividerTheme: const DividerThemeData(
          thickness: 1,
          color: Color(0xFFE5E5E5),
        ),
       // platform: GalleryOptions.of(context).platform,
      ),
      home: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return HomePage();/*const ApplyTextOptions(
      child:
    );*/
  }
}
