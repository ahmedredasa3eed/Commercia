import 'package:commercia/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  static const route = 'favourite-screen';

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 65),
        child: Stack(
          children: [
            CustomActionBar(title: "Favourite",isBackButton: false,),
          ],
        ),
      ),
    );
  }
}
