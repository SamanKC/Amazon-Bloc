import 'package:amazon_bloc/bloc/cart_items_bloc.dart';
import 'package:amazon_bloc/pages/bookmark.dart';
import 'package:amazon_bloc/pages/checkout.dart';
import 'package:amazon_bloc/pages/products.dart';
import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class ShopItems extends StatefulWidget {
  @override
  _ShopItemsState createState() => _ShopItemsState();
}

class _ShopItemsState extends State<ShopItems> {
  int _currentIndex = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Container(child: ProductList()),
              Container(child: BookmarkPage()),
              Container(child: Checkout()),
              Container(child: Checkout()),
            ],
          ),
        ),
        bottomNavigationBar: StreamBuilder(
            initialData: bloc.allItems,
            stream: bloc.getStream,
            builder: (context, snapshot) {
              print("sadffffffffffffffffffffffffffffff");
              print(
                snapshot.data['shop items'][0]['productTitle'],
              );

              return Card(
                elevation: 20,
                child: BottomNavyBar(
                  iconSize: 32,
                  containerHeight: 70,
                  selectedIndex: _currentIndex,
                  onItemSelected: (index) {
                    setState(() => _currentIndex = index);
                    _pageController.jumpToPage(index);
                  },
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                        title: Text('Home'), icon: Icon(Icons.home)),
                    BottomNavyBarItem(
                        title: Text('Bookmark'), icon: Icon(Icons.bookmark)),
                    BottomNavyBarItem(
                        title: Text('Wishlist'), icon: Icon(Icons.favorite)),
                    BottomNavyBarItem(
                      title: Text('Cart'),
                      icon: Badge(
                        shape: BadgeShape.circle,
                        child: Icon(Icons.shopping_cart),
                        badgeContent: Container(
                          height: 16,
                          width: 16,
                          child: Text(
                            snapshot.data['cart items'].length.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}

class ShopItemsWidget extends StatefulWidget {
  @override
  _ShopItemsWidgetState createState() => _ShopItemsWidgetState();
}

class _ShopItemsWidgetState extends State<ShopItemsWidget> {
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: StreamBuilder(
        initialData: bloc.allItems,
        stream: bloc.getStream,
        builder: (context, snapshot) {
          return shopItemsListBuilder(snapshot);
        },
      ),
    );
  }
}

Widget shopItemsListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["shop items"].length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, i) {
      final shopList = snapshot.data["shop items"];

      return Container(
        height: 300,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: () {
                        anotherbloc.bookmarkadd(shopList[i]);
                      },
                    ),
                    Image.asset(
                      shopList[i]['productImage'],
                      height: 130.0,
                      width: 180.0,
                    ),
                    Text(
                      shopList[i]['productTitle'],
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      shopList[i]['productTitle'],
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 80,
                          child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Text(
                                shopList[i]['productTitle'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey),
                              )),
                        ),
                        IconButton(
                          icon: Icon(
                              bloc.allItems['cart items'].contains(shopList[i])
                                  ? Icons.remove_shopping_cart
                                  : Icons.add_shopping_cart),
                          color:
                              bloc.allItems['cart items'].contains(shopList[i])
                                  ? Colors.red
                                  : Colors.green,
                          onPressed: () {
                            bloc.allItems['cart items'].contains(shopList[i])
                                ? bloc.removeFromCart(shopList[i])
                                : bloc.addToCart(shopList[i]);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
