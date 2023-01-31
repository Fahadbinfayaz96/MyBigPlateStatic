// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bigplate/models/category_model.dart';
import 'package:my_bigplate/models/final_amount_model.dart';

import 'package:my_bigplate/resources/repositories/categories_repository.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  CategoryRepository categoryRepository;
  CategoryProductsBloc(
    this.categoryRepository,
  ) : super(CategoryProductsInitial()) {
    on<CategoryProductsEvent>((event, emit) {
      if (event is LoadCategoryProducts) {
        emit(CategoryProductsInitial());
        emit(CategoryProductsLoaded(categoryItems: categoryRepository.items));
      }
    });
  }
}
