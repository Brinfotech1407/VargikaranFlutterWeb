import 'package:flutter/material.dart';
import 'package:vargikaran_web_app/layout/adaptive.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final double _formProgress = 0;
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return SafeArea(
      child: Padding(
        padding: isDesktop
            ? const EdgeInsets.symmetric(horizontal: 72, vertical: 48)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 270,
              padding: const EdgeInsets.all(8),
              child: Card(
                elevation: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('15744',style: TextStyle(color: Colors.lightBlue,fontSize: 20)),
                              Text('Total Files'),
                            ],
                          ),
                        ),
                        const Icon(Icons.file_copy_outlined),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: LinearProgressIndicator(value: _formProgress,minHeight: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('PROGRESS',style: TextStyle(fontSize: 11,color: Colors.grey)),
                          Text('70%',style: TextStyle(fontSize: 11,color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
