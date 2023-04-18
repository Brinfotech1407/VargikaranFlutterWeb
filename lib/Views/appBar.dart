import 'package:flutter/material.dart';
import 'package:vargikaran_web_app/classes/language.dart';
import 'package:vargikaran_web_app/classes/language_constants.dart';
import 'package:vargikaran_web_app/login_screen.dart';
import 'package:vargikaran_web_app/main.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({
    super.key,
    this.isDesktop = false,
  });

  final bool isDesktop;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    // final localizations = GalleryLocalizations.of(context)!;
    return AppBar(
      automaticallyImplyLeading: !isDesktop,
      backgroundColor: Colors.blueGrey,
      title: isDesktop
          ? Container(
        alignment: AlignmentDirectional.centerStart,
        child: SelectableText(
          'Navsari',
          style: themeData.textTheme.titleLarge!.copyWith(
            color: themeData.colorScheme.onPrimary,
          ),
        ),
      )
          : const SelectableText('title'/*localizations.starterAppGenericTitle*/),
      actions: [
        Align(
          alignment: Alignment.center,
          child: DropdownButton(
            isDense: true,
            icon: const Icon(
              Icons.language,
              color: Colors.white,

            ),
            alignment: Alignment.centerRight,
            onChanged: (Language? language) async {
              if (language != null) {
                Locale locale = await setLocale(language.languageCode);
                MyApp.setLocale(context, locale);
              }
            },
            items: Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (e) => DropdownMenuItem<Language>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      e.flag,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(e.name)
                  ],
                ),
              ),
            )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'logout',//localizations.starterAppTooltipShare,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen(),),
              );
            },
          ),
        ),
      ],

    );
  }
}