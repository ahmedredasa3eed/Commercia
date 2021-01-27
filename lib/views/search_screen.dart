import 'package:commercia/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {

  static const route = 'search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 65),
        child: Stack(
          children: [
            CustomActionBar(title: "Search Product",isBackButton: false,),
          ],
        ),
      ),
    );
  }
}
