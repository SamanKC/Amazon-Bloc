import 'package:amazon_bloc/pages/bookmark.dart';
import 'package:amazon_bloc/pages/checkout.dart';
import 'package:amazon_bloc/pages/shop_items.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => ShopItems(),
        '/checkout': (BuildContext context) => Checkout(),
        '/bookmark': (BuildContext context) => BookmarkPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
