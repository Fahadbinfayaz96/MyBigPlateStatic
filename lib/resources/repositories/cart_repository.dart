import 'dart:developer';

import 'package:my_bigplate/models/cart_item_model.dart';

class CartRepository {
  final List<CartItemModel> _shoppingCartList = [];
  addToShoppingCart(CartItemModel product) {
    if (_shoppingCartList.any(
      (element) =>
          element.id == product.id && element.isHalfItem == product.isHalfItem,
    )) {
      log('Product already in the cart!');
      // increaseProductQuantity(product: product);
      return;
    } else {
      _shoppingCartList.add(product);
      // increaseProductQuantity(product: product);
      return;
    }
  }

  removeFromShoppingCart(String productId, bool isHalfItem) {
    _shoppingCartList.removeWhere(
      (element) => element.id == productId && element.isHalfItem == isHalfItem,
    );
  }

  increaseProductQuantity({required CartItemModel product}) {
    // product.copyWith(quantity: product.quantity + 1);
    if (_shoppingCartList.any(
      (element) =>
          element.id == product.id && element.isHalfItem == product.isHalfItem,
    )) {
      _shoppingCartList
          .firstWhere(
            (element) =>
                element.id == product.id &&
                element.isHalfItem == product.isHalfItem,
          )
          .quantity++;
      log('${_shoppingCartList.firstWhere(
            (element) =>
                element.id == product.id &&
                element.isHalfItem == product.isHalfItem,
          ).quantity}');
    }
    return;
  }

  decreaseProductQuantity({required CartItemModel product}) {
    if (_shoppingCartList.any(
      (element) =>
          element.id == product.id && element.isHalfItem == product.isHalfItem,
    )) {
      _shoppingCartList
          .firstWhere(
            (element) =>
                element.id == product.id &&
                element.isHalfItem == product.isHalfItem,
          )
          .quantity--;
      log('${_shoppingCartList.firstWhere(
            (element) =>
                element.id == product.id &&
                element.isHalfItem == product.isHalfItem,
          ).quantity}');
    }
    return;
  }

  List<CartItemModel> get shoppingCartList =>
      _shoppingCartList.toSet().toList();
}
