import 'package:flutter/material.dart';
import 'package:vargikaran_web_app/Views/Drawer.dart';
import 'package:vargikaran_web_app/Views/appBar.dart';
import 'package:vargikaran_web_app/Views/dashboard.dart';
import 'package:vargikaran_web_app/Views/department_wise.dart';
import 'package:vargikaran_web_app/Views/files.dart';
import 'package:vargikaran_web_app/Views/search.dart';
import 'package:vargikaran_web_app/layout/adaptive.dart';

const appBarDesktopHeight = 128.0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<int> selectedDrawerFile = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = isDisplayDesktop(context);

    if (isDesktop) {
      return Row(
        children: [
          ListDrawer(
            selectedDrawerItem: (value) {
              selectedDrawerFile.value = value;
            },
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(
              appBar: const AdaptiveAppBar(
                isDesktop: true,
              ),
              body: buildShowBodyContent(),
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: const AdaptiveAppBar(),
        body: buildShowBodyContent(),
        drawer: ListDrawer(
          selectedDrawerItem: (value) {
            selectedDrawerFile.value = value;
          },
        ),
      );
    }
  }

  buildShowBodyContent() {
    return ValueListenableBuilder<int>(
      valueListenable: selectedDrawerFile,
      builder: (context, value, child) {
        switch (value) {
          case 0:
            return const DashBoardScreen();
          case 1:
            return const FilesScreen();
          case 2:
            return const DepartmentWiseScreen();
          case 3:
            return const SearchScreen();
          default:
            return const DashBoardScreen();
        }
      },
    );
  }
}
