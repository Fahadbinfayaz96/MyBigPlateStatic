// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bigplate/models/cart_item_model.dart';
import 'package:my_bigplate/models/final_amount_model.dart';

import 'package:my_bigplate/resources/repositories/cart_repository.dart';

part 'cart_products_event.dart';
part 'cart_products_state.dart';

class CartProductsBloc extends Bloc<CartProductsEvent, CartProductsState> {
  CartRepository cartRepository;
  CartProductsBloc(
    this.cartRepository,
  ) : super(CartProductsInitial()) {
    on<LoadCartProducts>(
      (event, emit) {
        emit(
          CartProductsLoaded(
            products: cartRepository.shoppingCartList,
            totalAmount: FinalAmountModel(
              itemTotal: totalAmout(cartRepository.shoppingCartList),
              tax: itemTax(cartRepository.shoppingCartList),
              totalAmount: amountToPay(cartRepository.shoppingCartList),
            ),
          ),
        );
      },
    );
    on<CartProductsEvent>((event, emit) {
      if (event is AddToCartEvent) {
        cartRepository.addToShoppingCart(
          event.product,
        );
        log('Cart length: ${cartRepository.shoppingCartList.length}');
        // add(IncreaseProductQuantityEvent(product: event.product));
        emit(
          CartProductsLoaded(
            products: cartRepository.shoppingCartList,
            totalAmount: FinalAmountModel(
              itemTotal: totalAmout(cartRepository.shoppingCartList),
              tax: itemTax(cartRepository.shoppingCartList),
              totalAmount: amountToPay(cartRepository.shoppingCartList),
            ),
          ),
        );
      }
      if (event is RemoveFromCartEvent) {
        cartRepository.removeFromShoppingCart(
          event.product.id,
          event.product.isHalfItem,
        );
        emit(
          CartProductsLoaded(
            products: cartRepository.shoppingCartList,
            totalAmount: FinalAmountModel(
              itemTotal: totalAmout(cartRepository.shoppingCartList),
              tax: itemTax(cartRepository.shoppingCartList),
              totalAmount: amountToPay(cartRepository.shoppingCartList),
            ),
          ),
        );
      }
    });
    on<IncreaseProductQuantityEvent>((event, emit) {
      cartRepository.increaseProductQuantity(product: event.product);
      emit(
        QuantityIncreasedState(quantity: event.product.quantity),
      );
      emit(
        CartProductsLoaded(
          products: cartRepository.shoppingCartList,
          totalAmount: FinalAmountModel(
            itemTotal: totalAmout(cartRepository.shoppingCartList),
            tax: itemTax(cartRepository.shoppingCartList),
            totalAmount: amountToPay(cartRepository.shoppingCartList),
          ),
        ),
      );
    });
    on<DecreaseProductQuantityEvent>((event, emit) {
      cartRepository.decreaseProductQuantity(product: event.product);
      emit(
        CartProductsLoaded(
          products: cartRepository.shoppingCartList,
          totalAmount: FinalAmountModel(
            itemTotal: totalAmout(cartRepository.shoppingCartList),
            tax: itemTax(cartRepository.shoppingCartList),
            totalAmount: amountToPay(cartRepository.shoppingCartList),
          ),
        ),
      );
    });
    on<GetFinalAmount>((event, emit) {
      emit(
        FinalAmountLoadedState(
          finalAmount: FinalAmountModel(
            itemTotal: totalAmout(event.products),
            tax: itemTax(event.products),
            totalAmount: amountToPay(event.products),
          ),
        ),
      );
    });
  }
}

double totalAmout(List<CartItemModel> products) {
  var total = 0.0;
  if (products.isNotEmpty) {
    for (var cartItem in products) {
      if (cartItem.isHalfItem) {
        total += (cartItem.halfPrice * cartItem.quantity);
      } else {
        total += (cartItem.price * cartItem.quantity);
      }
    }
  }
  return total;
}

double itemTax(List<CartItemModel> products) {
  var totalTax = 0.0;
  if (products.isNotEmpty) {
    for (var it in products) {
      totalTax += it.quantity * it.tax;
    }
  }
  return totalTax;
}

double amountToPay(List<CartItemModel> products) {
  var toPay = 0.0;
  if (products.isNotEmpty) {
    for (var itp in products) {
      toPay = totalAmout(products) + itemTax(products);
    }
  }

  return toPay;
}
