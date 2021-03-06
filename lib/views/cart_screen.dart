import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commercia/services.dart';
import 'package:commercia/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {

  static const route = 'cart-screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  FirebaseServices firebaseServices = FirebaseServices();

  Future  getCartContent() async{
    return  FirebaseFirestore.instance.collection("Users").doc(firebaseServices.getUserId()).collection("Cart").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 55),
        child: Stack(
          children: [
            CustomActionBar(
              title: "Cart",
              isBackButton: true,
              hasBackground: true,
            ),
          ],
        ),
      ),
    );
  }

}
