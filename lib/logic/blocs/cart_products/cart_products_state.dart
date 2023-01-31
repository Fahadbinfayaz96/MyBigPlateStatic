// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_products_bloc.dart';

abstract class CartProductsState extends Equatable {
  const CartProductsState();
}

class CartProductsInitial extends CartProductsState {
  @override
  List<Object?> get props => [];
}

class CartProductsLoaded extends CartProductsState {
  final List<CartItemModel> products;
  FinalAmountModel totalAmount;
  CartProductsLoaded({
    required this.products,
    required this.totalAmount,
  });
  @override
  List<Object?> get props => [products, totalAmount];
}

class QuantityIncreasedState extends CartProductsState {
  final int quantity;
  const QuantityIncreasedState({
    required this.quantity,
  });
  @override
  List<Object?> get props => [quantity];
}

class FinalAmountLoadedState extends CartProductsState {
  FinalAmountModel finalAmount;
  FinalAmountLoadedState({
    required this.finalAmount,
  });
  @override
  List<Object?> get props => [finalAmount];
}
