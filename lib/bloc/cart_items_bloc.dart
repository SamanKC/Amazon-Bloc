import 'dart:async';
import 'package:flutter/material.dart';

class CartItemsBloc extends SearchDelegate<CartItemsBloc> {
  
  final cartStreamController = StreamController.broadcast();
  final bookmarkStreamController = StreamController.broadcast();

  Stream get getStream => cartStreamController.stream;
  Stream get getStreambook => bookmarkStreamController.stream;

  final Map allItems = {
    'shop items': [
      {
        'productImage': 'images/applewatch.png',
        'productTitle': 'Apple1',
        'description': 'this is the description',
        'shortheading': 'Apple',
        'price': 300,
        'id': 1,
      },
      {
        'productImage': 'images/amazonlogo.png',
        'productTitle': 'Apple2',
        'description': 'this is the description',
        'rating': 'Icons.star',
        'shortheading': 'Apple',
        'price': 300,
        'id': 2,
      },
      {
        'productImage': 'images/applewatch.png',
        'productTitle': 'Apple3',
        'description': 'this is the description',
        'rating': 'Icons.star',
        'shortheading': 'Apple',
        'price': 300,
        'id': 3,
      },
      {
        'productImage': 'images/applewatch.png',
        'productTitle': 'Apple4',
        'description': 'this is the description',
        'rating': 'Icons.star',
        'shortheading': 'Apple',
        'price': 300,
        'id': 4,
      },
    ],
    'cart items': [],
    'book mark': [],
    'recent': [
      {
        'productImage': 'images/applewatch.png',
        'productTitle': 'Apple1',
        'description': 'this is the description',
        'shortheading': 'Apple',
        'price': 300,
        'id': 1,
      },
      {
        'productImage': 'images/applewatch.png',
        'productTitle': 'A1',
        'description': 'this is the description',
        'shortheading': 'Apple',
        'price': 300,
        'id': 1,
      },
    ]
  };
  // final products = ["Apple1", "Apple2", "Apple3", "Apple4"];
  // final recentProducts = ["apple"];


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
  
    return StreamBuilder(
      initialData: bloc.allItems,
      stream: bloc.getStream,
      builder: (context, snapshot) {
        final resultsList = snapshot.data['shop items'].where(
          (a) {
            return a.toString().toLowerCase().contains(query);
          },
        ).toList();
        print(
            "sdfjkhasdjkfasdf...........................................................");
        print(resultsList);
        // final result = snapshot.data['shop items']['context'];
        return ListView.builder(
          itemCount: resultsList.length,
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
                          Container(
                            height: 20,
                            width: 40,
                            child: IconButton(
                              icon: Icon(
                                Icons.bookmark_border,
                              ),
                              onPressed: () {
                                anotherbloc.bookmarkadd(shopList[i]);
                              },
                            ),
                          ),
                          Image.asset(
                            resultsList[i]['productImage'],
                            height: 130.0,
                            width: 180.0,
                          ),
                          Text(
                            resultsList[i]['productTitle'],
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            resultsList[i]['productTitle'],
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
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Text(
                                      resultsList[i]['productTitle'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey),
                                    )),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  bloc.addToCart(shopList[i]);
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
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
        initialData: bloc.allItems,
        stream: bloc.getStream,
        builder: (context, snapshot) {
          final suggestionList = query.isEmpty
              ? snapshot.data['recent']
              : snapshot.data['shop items'].where(
                  (a) {
                    return a['productTitle']
                        .toString()
                        .toLowerCase()
                        .startsWith(query);
                  },
                ).toList();

          return suggestionList.isEmpty
              ? Text("No results found")
              : ListView.builder(
                  itemCount: suggestionList.length,
                  itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          
                          showResults(context);
                        },
                        leading: Icon(Icons.backspace),
                        title: RichText(
                          text: TextSpan(
                              text: suggestionList[index]['productTitle']
                                  .substring(0, query.length),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: suggestionList[index]['productTitle']
                                        .substring(query.length),
                                    style: TextStyle(color: Colors.grey))
                              ]),
                        ),
                      ));
        });
  }

  void addToCart(item) {
    allItems['cart items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  void addToRecent(item) {
    allItems['recent'].add(item);
    cartStreamController.sink.add(allItems);
  }

  void bookmarkadd(item) {
    allItems['book mark'].add(item);
    bookmarkStreamController.sink.add(allItems);
  }

  void removeFrombookmark(item) {
    allItems['book mark'].remove(item);
    bookmarkStreamController.sink.add(allItems);
  }

  void removeFromCart(item) {
    allItems['cart items'].remove(item);

    cartStreamController.sink.add(allItems);
  }

  void dispose() {
    cartStreamController.close();
    bookmarkStreamController.close();
  }
}

final bloc = CartItemsBloc();
final anotherbloc = CartItemsBloc();
