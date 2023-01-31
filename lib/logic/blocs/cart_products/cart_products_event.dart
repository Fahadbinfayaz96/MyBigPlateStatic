// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_products_bloc.dart';

abstract class CartProductsEvent extends Equatable {
  const CartProductsEvent();
}

class LoadCartProducts extends CartProductsEvent {
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartProductsEvent {
  final CartItemModel product;
  const AddToCartEvent({
    required this.product,
  });
  @override
  List<Object?> get props => [product];
}

class RemoveFromCartEvent extends CartProductsEvent {
  final CartItemModel product;
  const RemoveFromCartEvent({
    required this.product,
  });
  @override
  List<Object?> get props => [product];
}

class IncreaseProductQuantityEvent extends CartProductsEvent {
  final CartItemModel product;
  const IncreaseProductQuantityEvent({
    required this.product,
  });
  @override
  List<Object?> get props => [product.quantity];
}

class DecreaseProductQuantityEvent extends CartProductsEvent {
  final CartItemModel product;
  const DecreaseProductQuantityEvent({
    required this.product,
  });
  @override
  List<Object?> get props => [product];
}

class GetFinalAmount extends CartProductsEvent {
  List<CartItemModel> products;
  GetFinalAmount({
    required this.products,
  });
  @override
  List<Object?> get props => [products];
}
