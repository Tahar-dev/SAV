import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Calendrier", "1", "lib/images/cal2.png", Colors.blue],
    ["  Demandes\nd'intervention", "2", "lib/images/demande.png", Colors.orange],
    ["  Historique\nd'intervention", "3", "lib/images/to-do-list.png", Colors.brown],
    ["Fournisseurs", "4", "lib/images/supply-chain-management.png", Colors.green],
    ["Admin", "5", "lib/images/admin.png", Colors.red],
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
   // _cartItems.add(_shopItems[index]);
   // notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    //_cartItems.removeAt(index);
    //notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    /*for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }*/
    return totalPrice.toStringAsFixed(2);
  }
}
