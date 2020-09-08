import 'package:amazon_bloc/bloc/cart_items_bloc.dart';
import 'package:amazon_bloc/pages/topBar.dart';

import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: streamProducts(),
    );
  }
}

Widget streamProducts() {
  return StreamBuilder(
    stream: bloc.getStream,
    initialData: bloc.allItems,
    builder: (context, snapshot) {
      return snapshot.data['cart items'].length > 0
          ? Column(
              children: <Widget>[
                TopBar(),
                Expanded(child: checkoutListBuilder(snapshot)),
              ],
            )
          : Column(
              children: <Widget>[
                TopBar(),
                Center(child: Text("You haven't taken any item yet"))
              ],
            );
    },
  );
}

Widget checkoutListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["cart items"].length,
    itemBuilder: (BuildContext context, i) {
      final cartList = snapshot.data["cart items"];

      return Container(
          margin: new EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: 25.0,
          height: 130.0,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          cartList[i]['productImage'],
                          height: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(cartList[i]['productTitle']),
                            Text(
                              cartList[i]['shortheading'],
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              cartList[i]['description'],
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 80,
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Text(
                                    "\$${cartList[i]['price']}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                  )),
                            ),
                            RaisedButton(
                                onPressed: () {
                                  bloc.removeFromCart(cartList[i]);
                                },
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white)),
                                child: Text(
                                  "Delete",
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    },
  );
}
