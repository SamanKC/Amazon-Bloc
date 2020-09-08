import 'package:amazon_bloc/bloc/cart_items_bloc.dart';

import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Card(
        
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.dehaze,
              size: 30.0,
            ),
            Image.asset(
              'images/amazonlogo.png',
              height: 90.0,
            ),
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () => Navigator.pushNamed(context, '/bookmark')),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          right: 18.0,
        ),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30.0,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                     showSearch(
                          context: context, delegate: CartItemsBloc());
                    },
                  );
                },
              ),
              Text(
                "Search",
                style: TextStyle(fontSize: 28.0, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
