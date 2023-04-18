import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListDrawer extends StatefulWidget {

  Function(int) selectedDrawerItem;
   ListDrawer({super.key,required this.selectedDrawerItem});

  @override
  State<ListDrawer> createState() => _ListDrawerState();
}

class _ListDrawerState extends State<ListDrawer> {
  static const numItems = 4;

  //int selectedItem = 0;
  ValueNotifier<int> selectedItem  = ValueNotifier<int>(0);

  @override
  void initState() {
    widget.selectedDrawerItem(selectedItem.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    //  final localizations = GalleryLocalizations.of(context)!;
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 56,
              child: ListTile(
                tileColor: Colors.blueGrey,
                title: SelectableText(
                  'RMS',
                  //  localizations.starterAppTitle,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            ...Iterable<int>.generate(numItems).toList().map((i) {
              return ValueListenableBuilder<int>(
                valueListenable: selectedItem,
                builder: (context, selectedItemValue, child) {
                  return ListTile(
                    enabled: true,
                    selected: i == selectedItemValue,
                    selectedTileColor: Colors.white12,
                    subtitle: const Divider(height: 0.5),
                    leading: getIconForDrawer(i+1),
                    title:  Text(
                      getTextForDrawer(i + 1),
                      //'Item {value}',
                      //localizations.starterAppDrawerItem(i + 1),
                    ),
                    onTap: () {
                      selectedItem.value = i;
                      widget.selectedDrawerItem(selectedItem.value);
                    },
                  );
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