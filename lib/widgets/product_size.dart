import 'package:commercia/constants/constant.dart';
import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSizes;
  final Function(String) onSelected;
  ProductSize({this.productSizes,this.onSelected});

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizes.length; i++)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  widget.onSelected("${widget.productSizes[i]}");
                  setState(() {
                    selectedSize = i;
                  });
                },
                child: Container(
                  child: Text(
                    widget.productSizes[i],
                    textAlign: TextAlign.center,
                    style: Constants.kRegular2Text,
                  ),
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: selectedSize == i ? Theme.of(context).accentColor : Colors.grey,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
