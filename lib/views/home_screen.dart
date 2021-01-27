import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commercia/constants/constant.dart';
import 'package:commercia/shared/loading.dart';
import 'package:commercia/views/product_details.dart';
import 'package:commercia/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const route = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final productCollectionRef = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 55),
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: productCollectionRef.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(productId: snapshot.data.docs[index].id,)));
                      },
                      child: Stack(
                        children: [
                          Container(
                            width:double.infinity,
                            padding: EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data.docs[index]['images'][0],
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                fadeInCurve: Curves.easeIn,
                                fadeOutDuration: Duration(milliseconds: 1000),
                                fit: BoxFit.cover,
                                height: 250,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left:0,
                            right:0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(snapshot.data.docs[index]['name'],style: Constants.kTitleText,),
                                Text("${snapshot.data.docs[index]['price']} \$",style: Constants.kPriceText,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            CustomActionBar(
              title: "Home",
              isBackButton: false,
              hasBackground: true,
            ),
          ],
        ),
      ),
    );
  }
}
