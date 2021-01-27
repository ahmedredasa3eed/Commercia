import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commercia/constants/constant.dart';
import 'package:commercia/shared/loading.dart';
import 'package:commercia/views/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool isBackButton;
  final bool hasBackground;
  final Function onPressed;
  CustomActionBar({this.title, this.isBackButton,this.hasBackground,this.onPressed});

  User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0,0),
          end: Alignment(0,2),
        ) : null
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isBackButton
              ? GestureDetector(
            onTap: onPressed,
                child: Container(
                    padding: EdgeInsets.all(8),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        )),
                    child: Icon(Icons.arrow_back,color: Colors.white,),
                  ),
              )
              : Text(
                  title,
                  style: Constants.kTitleText,
                ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, CartScreen.route);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  )),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Users").doc(_user.uid).collection("Cart").snapshots(),
                builder: (context,streamSnapshot){
                  if(streamSnapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  return Text("${streamSnapshot.data.docs.length}",
                    textAlign: TextAlign.center,
                    style: Constants.kRegular2Text.copyWith(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
