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
    return Container(height: 300,width: 500,color: Colors.blueGrey,);
  }
}
