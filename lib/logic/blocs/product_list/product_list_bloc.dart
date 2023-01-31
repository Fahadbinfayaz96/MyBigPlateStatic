// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bigplate/models/product_model.dart';

import 'package:my_bigplate/resources/repositories/product_list_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductlistRepository productlistRepository;
  ProductListBloc(
    this.productlistRepository,
  ) : super(ProductListInitial()) {
    List<ProductModel> products = [];
    on<ProductListEvent>((event, emit) {
      if (event is LoadProductList) {
        products = productlistRepository.items
            .where((element) => element.categoryId == event.categoryId)
            .toList();
        emit(ProductListLoaded(productList: products));
      }
    });
  }
}
