import 'package:commercia/auth/auth_screen.dart';
import 'package:commercia/views/cart_screen.dart';
import 'package:commercia/views/product_details.dart';
import 'package:commercia/views/tabs_screen.dart';
import 'package:commercia/views/favourite-screen.dart';
import 'package:commercia/views/home_screen.dart';
import 'package:commercia/views/search_screen.dart';
import 'package:commercia/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commercia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        accentColor: Colors.deepOrange,
      ),
      home: TabsScreen(),
      routes: {
        AuthScreen.route : (context) => AuthScreen(),
        HomeScreen.route : (context) => HomeScreen(),
        SearchScreen.route : (context) => SearchScreen(),
        FavouriteScreen.route : (context) => FavouriteScreen(),
        ProductDetailsScreen.route : (context) => ProductDetailsScreen(),
        CartScreen.route : (context) => CartScreen(),
      },
    );
  }
}

