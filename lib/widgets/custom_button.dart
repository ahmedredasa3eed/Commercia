import 'package:commercia/constants/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final text;
  final Function onPressed;
  bool isOutlinedBorder;

  CustomButton({this.text, this.onPressed, this.isOutlinedBorder});

  @override
  Widget build(BuildContext context) {

    bool _isOutlinedBorder = isOutlinedBorder ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 12,),
        decoration: BoxDecoration(
          color: _isOutlinedBorder ? Colors.transparent : Colors.black,
          border:  Border.all(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(text,style: _isOutlinedBorder ? Constants.kRegularText : Constants.kRegular2Text,),
      ),
    );
  }
}
