// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:my_bigplate/logic/blocs/cart_products/cart_products_bloc.dart';
import 'package:my_bigplate/logic/blocs/product_list/product_list_bloc.dart';
import 'package:my_bigplate/models/product_model.dart';
import 'package:my_bigplate/presentation/utils/colors/app_colors.dart';
import 'package:my_bigplate/presentation/utils/my_icons.dart';
import 'package:my_bigplate/presentation/widgets/dialog_widget.dart';

class CartItem extends StatelessWidget {
  final int index;
  CartProductsLoaded cartState;
  CartItem({
    Key? key,
    required this.index,
    required this.cartState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListLoaded) {
              return SlidableAction(
                icon: Icons.delete,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                backgroundColor: Colors.red.withOpacity(0.3),
                onPressed: ((context) {
                  BlocProvider.of<CartProductsBloc>(context).add(
                    RemoveFromCartEvent(
                      product: cartState.products[index],
                    ),
                  );
                }),
              );
            }
            return const SizedBox();
          },
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 3)
          ],
        ),
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      cartState.products[index].itemName,
                      style: const TextStyle(
                          fontFamily: "Mansory",
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    cartState.products[index].foodType == "veg"
                        ? Icon(
                            MyIcons.veg,
                            color: Colors.green,
                          )
                        : Icon(
                            MyIcons.veg,
                            color: Colors.red,
                          ),
                    const Expanded(child: SizedBox()),
                    Text(
                      cartState.products[index].isHalfItem
                          ? "${cartState.products[index].halfPrice}"
                          : "${cartState.products[index].price}",
                      style: const TextStyle(fontFamily: "Mansory"),
                    )
                  ],
                ),
                Row(
                  children: [
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
                            return CartItemQuantity(
                              index: index,
                              isHalfItem: true,
                              itemQuantity: cartState.products[index].quantity,
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      cartState.products[index].isHalfItem
                          ? "${cartState.products[index].halfPrice * cartState.products[index].quantity}"
                          : "${cartState.products[index].price * cartState.products[index].quantity}",
                      style: const TextStyle(fontFamily: "Mansory"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemQuantity extends StatefulWidget {
  CartItemQuantity({
    super.key,
    required this.index,
    this.itemQuantity = 0,
    required this.isHalfItem,
  });
  final int index;
  int itemQuantity;
  final bool isHalfItem;

  @override
  State<CartItemQuantity> createState() => _CartItemQuantityState();
}

class _CartItemQuantityState extends State<CartItemQuantity> {
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
              return Row(
                children: [
                  Material(
                    color: AppColors.colorPrimary,
                    child: InkWell(
                      onTap: () {
                        if (widget.itemQuantity > 0) {
                          BlocProvider.of<CartProductsBloc>(context).add(
                            DecreaseProductQuantityEvent(
                              product: cartState.products[widget.index],
                            ),
                          );

                          setState(() {
                            widget.itemQuantity--;
                          });
                          widget.isHalfItem
                              ? halfItemQuantity = widget.itemQuantity
                              : fullItemQuantity = widget.itemQuantity;
                          log('Half Item quantity: $halfItemQuantity');
                          if (widget.itemQuantity == 0) {
                            BlocProvider.of<CartProductsBloc>(context).add(
                              RemoveFromCartEvent(
                                product: cartState.products[widget.index],
                              ),
                            );
                          }
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
                        if (widget.itemQuantity > 0) {
                          BlocProvider.of<CartProductsBloc>(context).add(
                            IncreaseProductQuantityEvent(
                              product: cartState.products[widget.index],
                            ),
                          );
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
