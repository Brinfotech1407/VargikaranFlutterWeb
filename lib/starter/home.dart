
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vargikaran_web_app/classes/language.dart';

import 'package:vargikaran_web_app/layout/adaptive.dart';
import 'package:vargikaran_web_app/main.dart';


import '../classes/language_constants.dart';

const appBarDesktopHeight = 128.0;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = isDisplayDesktop(context);
   // final localizations = GalleryLocalizations.of(context)!;
    final body = SafeArea(
      child: Padding(
        padding: isDesktop
            ? const EdgeInsets.symmetric(horizontal: 72, vertical: 48)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context).helloWorld),
            /*SelectableText(
              localizations.starterAppGenericHeadline,
              style: textTheme.displaySmall!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),*/
            const SizedBox(height: 10),
            const Text('Subtitle'),
         /*   SelectableText(
              localizations.starterAppGenericSubtitle,
              style: textTheme.titleMedium,
            ),*/
            const SizedBox(height: 48),
            const Text('Body'),
           /* SelectableText(
              localizations.starterAppGenericBody,
              style: textTheme.bodyLarge,
            ),*/
          ],
        ),
      ),
    );

    if (isDesktop) {
      return Row(
        children: [
          const ListDrawer(),
          const VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(
              appBar: const AdaptiveAppBar(
                isDesktop: true,
              ),
              body: body,
              floatingActionButton: FloatingActionButton.extended(
                heroTag: 'Extended Add',
                onPressed: () {},
                label: Text(
                  'BUTTON',//localizations.starterAppGenericButton,
                  style: TextStyle(color: colorScheme.onSecondary),
                ),
                icon: Icon(Icons.add, color: colorScheme.onSecondary),
                tooltip: 'Add',// localizations.starterAppTooltipAdd,
              ),
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: const AdaptiveAppBar(),
        body: body,
        drawer: const ListDrawer(),
        floatingActionButton: FloatingActionButton(
          heroTag: 'Add',
          onPressed: () {},
          tooltip: 'Add',//localizations.starterAppTooltipAdd,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      );
    }
  }
}

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({
    super.key,
    this.isDesktop = false,
  });

  final bool isDesktop;

  @override
  Size get preferredSize => isDesktop
      ? const Size.fromHeight(appBarDesktopHeight)
      : const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
  // final localizations = GalleryLocalizations.of(context)!;
    return AppBar(
      automaticallyImplyLeading: !isDesktop,
      title: isDesktop
          ? null
          : const SelectableText('title'/*localizations.starterAppGenericTitle*/),
      bottom: isDesktop
          ? PreferredSize(
              preferredSize: const Size.fromHeight(26),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                margin: const EdgeInsetsDirectional.fromSTEB(72, 0, 0, 22),
                child: SelectableText(
                  'AppLocalizations.of(context).helloWorld',
                  style: themeData.textTheme.titleLarge!.copyWith(
                    color: themeData.colorScheme.onPrimary,
                  ),
                ),
              ),
            )
          : null,
      actions: [
        DropdownButton(
          underline: const SizedBox(),
          icon: const Icon(
            Icons.language,
            color: Colors.white,
          ),
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
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: 'Share',//localizations.starterAppTooltipShare,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.favorite),
          tooltip:'Favorite', //localizations.starterAppTooltipFavorite,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search),
          tooltip:'Search', //localizations.starterAppTooltipSearch,
          onPressed: () {},
        ),
      ],
    );
  }
}

class ListDrawer extends StatefulWidget {
  const ListDrawer({super.key});

  @override
  State<ListDrawer> createState() => _ListDrawerState();
}

class _ListDrawerState extends State<ListDrawer> {
  static const numItems = 4;

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
  //  final localizations = GalleryLocalizations.of(context)!;
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: SelectableText(
                'RMS',
              //  localizations.starterAppTitle,
                style: textTheme.titleLarge,
              ),
            ),
            const Divider(),
            ...Iterable<int>.generate(numItems).toList().map((i) {
              return ListTile(
                enabled: true,
                selected: i == selectedItem,
                selectedTileColor: Colors.white12,
                subtitle: Divider(height: 0.5),
                leading: getIconForDrawer(i+1),
                title:  Text(
                  getTextForDrawer(i + 1),
                  //'Item {value}',
                  //localizations.starterAppDrawerItem(i + 1),
                ),
                onTap: () {
                  setState(() {
                    selectedItem = i;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Icon getIconForDrawer(int index) {
    switch (index){
      case 1:
        return  const Icon(Icons.home);
        case 2:
        return  const Icon(Icons.file_copy_sharp);
        case 3:
        return  const Icon(Icons.file_copy_sharp);
        case 4:
        return   const Icon(Icons.file_copy_sharp);
      default:
        return    const Icon(Icons.home);
    }
  }

  String getTextForDrawer(int index) {
    switch (index){
      case 1:
        return  AppLocalizations.of(context).drawerFile1;
      case 2:
        return  AppLocalizations.of(context).drawerFile2;
      case 3:
        return  AppLocalizations.of(context).drawerFile3;
      case 4:
        return  AppLocalizations.of(context).drawerFile4;
      default:
        return  AppLocalizations.of(context).drawerFile1;
    }
  }
}
