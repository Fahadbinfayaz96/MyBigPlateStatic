// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_products_bloc.dart';

abstract class CategoryProductsState extends Equatable {
  const CategoryProductsState();
}

class CategoryProductsInitial extends CategoryProductsState {
  @override
  List<Object?> get props => [];
}

class CategoryProductsLoaded extends CategoryProductsState {
  final List<CategoriesModel> categoryItems;
  const CategoryProductsLoaded({
    required this.categoryItems,
  });
  @override
  List<Object?> get props => [];
}
