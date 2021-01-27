import 'package:commercia/constants/constant.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {

  final String hintText;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  TextEditingController controller;
  final bool obscureText;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  FormInput({this.hintText, this.prefixIcon, this.keyboardType, this.controller,this.obscureText,this.onSubmitted,this.focusNode,this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        focusNode: focusNode,
        textInputAction: textInputAction,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        style: Constants.kFormHintText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: Constants.kFormHintText,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.all(16),
        ),
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}
