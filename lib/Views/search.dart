import 'package:flutter/material.dart';
import 'package:vargikaran_web_app/vargikarn_utiles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final fileNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Utils().buildRowText('Fn. No'),
                        Expanded(
                          child: Utils().textFormFiledView(
                            controller: fileNoController,
                            hintText: 'Enter F.N No',
                            autofillHints: [AutofillHints.creditCardName],
                            textInputType: TextInputType.number,
                            keyboardType: TextInputType.number,
                            validator: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Utils().buildRowText('Fn. No'),
                        Expanded(
                          child: Utils().textFormFiledView(
                            controller: fileNoController,
                            hintText: 'Enter F.N No',
                            autofillHints: [AutofillHints.creditCardName],
                            textInputType: TextInputType.number,
                            keyboardType: TextInputType.number,
                            validator: (value) {},
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Utils().buildRowText('Fn. No'),
                        Expanded(
                          child: Utils().textFormFiledView(
                            controller: fileNoController,
                            hintText: 'Enter F.N No',
                            autofillHints: [AutofillHints.creditCardName],
                            textInputType: TextInputType.number,
                            keyboardType: TextInputType.number,
                            validator: (value) {},
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              )),
          Container(height: 400, color: Colors.orange),
          Container(height: 150, color: Colors.green),
        ],
      ),
    );
  }
}
