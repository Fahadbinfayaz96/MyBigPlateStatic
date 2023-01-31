part of 'category_products_bloc.dart';

abstract class CategoryProductsEvent extends Equatable {
  const CategoryProductsEvent();
}

class LoadCategoryProducts extends CategoryProductsEvent {
  @override
  List<Object?> get props => [];
}
