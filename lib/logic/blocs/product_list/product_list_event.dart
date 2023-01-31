part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();
}

class LoadProductList extends ProductListEvent {
  final String categoryId;

  const LoadProductList(this.categoryId);
  @override
  List<Object?> get props => [];
}
