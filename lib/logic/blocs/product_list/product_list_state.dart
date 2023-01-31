// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
}

class ProductListInitial extends ProductListState {
  @override
  List<Object?> get props => [];
}

class ProductListLoaded extends ProductListState {
  final List<ProductModel> productList;
  const ProductListLoaded({
    required this.productList,
  });
  @override
  List<Object?> get props => [productList];
}
