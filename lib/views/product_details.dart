import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commercia/constants/constant.dart';
import 'package:commercia/shared/loading.dart';
import 'package:commercia/widgets/custom_action_bar.dart';
import 'package:commercia/widgets/image_slider.dart';
import 'package:commercia/widgets/product_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const route = 'product-details';

  final String productId;

  String productSize = '0';

  ProductDetailsScreen({this.productId});

  final productCollectionRef = FirebaseFirestore.instance.collection(
      "Products");

  final userCollectionRef = FirebaseFirestore.instance.collection("Users");


  Future<void> addToCart() async {
    User _user = FirebaseAuth.instance.currentUser;
    userCollectionRef.doc(_user.uid).collection("Cart").doc(productId).set(
        {
          'size': productSize,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FutureBuilder(
              future: productCollectionRef.doc(productId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }

                List productImagesList = snapshot.data['images'];
                List productSizeList = snapshot.data['size'];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageSlider(images: productImagesList),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          snapshot.data['name'],
                          style: Constants.kTitleText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          "${snapshot.data['price']} \$",
                          style: Constants.kPriceText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          snapshot.data['desc'],
                          style: Constants.kRegularText
                              .copyWith(fontSize: 17, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          "Select Size",
                          style: Constants.kTitleText,
                        ),
                      ),
                      ProductSize(productSizes: productSizeList, onSelected:(size){
                        productSize = size;
                      },),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 5,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.bookmark_border_outlined),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await addToCart();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text("Add To Cart",
                                    style: Constants.kRegular2Text,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: CustomActionBar(
                title: "",
                isBackButton: true,
                hasBackground: false,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
