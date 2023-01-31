import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_bigplate/logic/blocs/cart_products/cart_products_bloc.dart';
import 'package:my_bigplate/logic/blocs/product_list/product_list_bloc.dart';
import 'package:my_bigplate/models/cart_item_model.dart';
import 'package:my_bigplate/models/product_model.dart';
import 'package:my_bigplate/presentation/utils/colors/app_colors.dart';

late int halfItemQuantity = 0;
late int fullItemQuantity = 0;

class DialogWidget extends StatelessWidget {
  final int index;
  DialogWidget({
    super.key,
    required this.index,
  });

  late ProductModel productItem;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        if (state is ProductListLoaded) {
          productItem = state.productList[index];
          return Center(
            child: Container(
              width: 300.w,
              height: 400.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: AppColors.colorGrey,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12.sp,
                vertical: 18.sp,
              ),
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Place your order!',
                      style: TextStyle(
                        backgroundColor: const Color.fromARGB(28, 0, 0, 0),
                        color: const Color.fromARGB(255, 208, 130, 28),
                        fontWeight: FontWeight.w500,
                        fontSize: 19.sp,
                      ),
                    ),
                    const Divider(
                      thickness: 1.7,
                      color: AppColors.dividerColor,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.sp),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(10.sp),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    state.productList[index].foodType == "veg"
                                        ? Colors.green
                                        : Colors.red,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.all(3),
                            height: 20,
                            width: 20,
                            child: const CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 10,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            state.productList[index].itemName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.sp),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        children: [
                          FullOrHalfItem(
                            index: index,
                            state: state,
                            isHalfItem: true,
                          ),
                          const Divider(
                            thickness: 1.7,
                            color: AppColors.dividerColor,
                          ),
                          FullOrHalfItem(
                            index: index,
                            state: state,
                            isHalfItem: false,
                          ),
                          const Divider(
                            thickness: 1.7,
                            color: AppColors.dividerColor,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 34.sp,
                                vertical: 10.sp,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12.sp,
                                ),
                              ),
                              elevation: 0,
                              backgroundColor: AppColors.colorPrimary,
                              foregroundColor: AppColors.colorWhite,
                            ),
                            onPressed: () {
                              if (fullItemQuantity > 0) {
                                productItem = state.productList[index];
                                BlocProvider.of<CartProductsBloc>(context).add(
                                  AddToCartEvent(
                                    product: CartItemModel(
                                      id: productItem.id,
                                      categoryId: productItem.categoryId,
                                      foodType: productItem.foodType,
                                      itemName: productItem.itemName,
                                      description: productItem.description,
                                      price: productItem.price,
                                      halfPrice: productItem.halfPrice,
                                      imagePath: productItem.imagePath,
                                      isHalfItem: false,
                                      quantity: fullItemQuantity,
                                    ),
                                  ),
                                );
                              }
                              if (halfItemQuantity > 0) {
                                productItem = state.productList[index];
                                BlocProvider.of<CartProductsBloc>(context).add(
                                  AddToCartEvent(
                                    product: CartItemModel(
                                      id: productItem.id,
                                      categoryId: productItem.categoryId,
                                      foodType: productItem.foodType,
                                      itemName: productItem.itemName,
                                      description: productItem.description,
                                      price: productItem.price,
                                      halfPrice: productItem.halfPrice,
                                      imagePath: productItem.imagePath,
                                      isHalfItem: true,
                                      quantity: halfItemQuantity,
                                      tax: 0.9,
                                    ),
                                  ),
                                );
                              }
                              fullItemQuantity = 0;
                              halfItemQuantity = 0;
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Add to cart',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class FullOrHalfItem extends StatelessWidget {
  FullOrHalfItem({
    Key? key,
    required this.index,
    required this.state,
    required this.isHalfItem,
  }) : super(key: key);

  final int index;
  ProductListLoaded state;
  final bool isHalfItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isHalfItem ? 'Half' : 'Full',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(isHalfItem
            ? '₹${state.productList[index].halfPrice}'
            : '₹${state.productList[index].price}'),
        SizedBox(
          width: 10.w,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.sp,
            horizontal: 10.sp,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: AppColors.colorPrimary,
          ),
          child: BlocBuilder<CartProductsBloc, CartProductsState>(
            builder: (context, cartState) {
              if (cartState is CartProductsLoaded) {
                return ItemQuantity(
                  index: index,
                  isHalfItem: isHalfItem,
                  itemQuantity: cartState.products.any(
                    (element) =>
                        element.id == state.productList[index].id &&
                        element.isHalfItem == isHalfItem,
                  )
                      ? cartState.products
                          .firstWhere(
                            (element) =>
                                element.id == state.productList[index].id &&
                                element.isHalfItem == isHalfItem,
                          )
                          .quantity
                      : 0,
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}

class ItemQuantity extends StatefulWidget {
  ItemQuantity({
    super.key,
    required this.index,
    this.itemQuantity = 0,
    required this.isHalfItem,
  });
  final int index;
  int itemQuantity;
  final bool isHalfItem;

  @override
  State<ItemQuantity> createState() => _ItemQuantityState();
}

class _ItemQuantityState extends State<ItemQuantity> {
  @override
  void initState() {
    super.initState();
  }

  late ProductModel productItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        return BlocBuilder<CartProductsBloc, CartProductsState>(
            builder: (context, cartState) {
          if (cartState is CartProductsLoaded) {
            if (state is ProductListLoaded) {
              productItem = state.productList[widget.index];
              return Row(
                children: [
                  Material(
                    color: AppColors.colorPrimary,
                    child: InkWell(
                      onTap: () {
                        if (cartState.products.any(
                          (element) =>
                              element.id == productItem.id &&
                              element.isHalfItem == widget.isHalfItem,
                        )) {
                          if (widget.itemQuantity > 0) {
                            setState(() {
                              widget.itemQuantity--;
                            });
                            widget.isHalfItem
                                ? halfItemQuantity = widget.itemQuantity
                                : fullItemQuantity = widget.itemQuantity;
                            BlocProvider.of<CartProductsBloc>(context).add(
                              DecreaseProductQuantityEvent(
                                product: cartState.products.firstWhere(
                                  (element) =>
                                      element.id == productItem.id &&
                                      element.isHalfItem == widget.isHalfItem,
                                ),
                              ),
                            );
                            log('Half Item quantity: $halfItemQuantity');
                            return;
                          }
                        }
                        if (widget.itemQuantity > 0) {
                          setState(() {
                            widget.itemQuantity--;
                          });
                          widget.isHalfItem
                              ? halfItemQuantity = widget.itemQuantity
                              : fullItemQuantity = widget.itemQuantity;
                          log('Half Item quantity: $halfItemQuantity');
                          return;
                        }
                      },
                      child: Icon(
                        FontAwesomeIcons.minus,
                        size: 10.sp,
                        color: AppColors.colorWhite,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                    child: Text(
                      widget.itemQuantity.toString(),
                      style: const TextStyle(
                        color: AppColors.colorWhite,
                      ),
                    ),
                  ),
                  Material(
                    color: AppColors.colorPrimary,
                    child: InkWell(
                      onTap: () {
                        if (cartState.products.any(
                          (element) =>
                              element.id == productItem.id &&
                              element.isHalfItem == widget.isHalfItem,
                        )) {
                          if (widget.itemQuantity > 0) {
                            setState(() {
                              widget.itemQuantity++;
                            });
                            widget.isHalfItem
                                ? halfItemQuantity = widget.itemQuantity
                                : fullItemQuantity = widget.itemQuantity;
                            BlocProvider.of<CartProductsBloc>(context).add(
                              IncreaseProductQuantityEvent(
                                product: cartState.products.firstWhere(
                                  (element) =>
                                      element.id == productItem.id &&
                                      element.isHalfItem == widget.isHalfItem,
                                ),
                              ),
                            );
                            log('Half Item quantity: $halfItemQuantity');
                            return;
                          }
                        }
                        setState(() {
                          widget.itemQuantity++;
                        });
                        widget.isHalfItem
                            ? halfItemQuantity = widget.itemQuantity
                            : fullItemQuantity = widget.itemQuantity;
                        log('Half Item quantity: $halfItemQuantity');
                      },
                      child: Icon(
                        FontAwesomeIcons.plus,
                        size: 10.sp,
                        color: AppColors.colorWhite,
                      ),
                    ),
                  ),
                ],
              );
            }
          }

          return const SizedBox();
        });
      },
    );
  }
}

// productItem = state.productList[index];
//                         BlocProvider.of<CartProductsBloc>(context)
//                             .add(AddToCartEvent(
//                           product: CartItemModel(
//                             id: productItem.id,
//                             categoryId: productItem.categoryId,
//                             foodType: productItem.foodType,
//                             itemName: productItem.itemName,
//                             description: productItem.description,
//                             price: productItem.price,
//                             halfPrice: productItem.halfPrice,
//                             imagePath: productItem.imagePath,
//                             isHalfItem: true,
//                           ),
//                         ));