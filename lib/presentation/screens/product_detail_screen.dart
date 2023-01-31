import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bigplate/logic/blocs/cart_products/cart_products_bloc.dart';
import 'package:my_bigplate/logic/blocs/product_list/product_list_bloc.dart';
import 'package:my_bigplate/models/cart_item_model.dart';
import 'package:my_bigplate/models/product_model.dart';
import 'package:my_bigplate/presentation/screens/cart.dart';
import 'package:my_bigplate/presentation/utils/colors/app_colors.dart';

int halfCartItemQuantity = 0;
int fullCartItemQuantity = 0;

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Product Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(
              'https://b.zmtcdn.com/data/pictures/1/6102331/87fb377aa9b4603867c10f071d62000b.jpg?output-format=webp&fit=around|300:273&crop=300:273;*,*',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 15.w,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: productModel.foodType == "veg"
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
                width: 10.w,
              ),
              Expanded(
                child: Text(
                  productModel.itemName,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    height: 1,
                    fontFamily: 'Mansory',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const Spacer(),
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (
                        BuildContext context,
                      ) {
                        return Center(
                          child: ProductDetailDialog(
                            product: productModel,
                          ),
                        );
                      },
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 5.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          Icons.add,
                          size: 20.sp,
                          color: AppColors.colorWhite,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.all(15.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  productModel.description,
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 97, 97, 97),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 10,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Cart(),
              ),
            );
          },
          child: const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: Icon(
                FontAwesomeIcons.cartShopping,
                size: 35,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 76.h,
        child: const BottomAppBar(
          color: Colors.orange,
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
        ),
      ),
    );
  }
}

class ProductDetailDialog extends StatelessWidget {
  const ProductDetailDialog({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoaded) {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                    ),
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
                                color: product.foodType == "veg"
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
                            product.itemName.toString(),
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
                            productModel: product,
                            state: state,
                            isHalfItem: true,
                          ),
                          const Divider(
                            thickness: 1.7,
                            color: AppColors.dividerColor,
                          ),
                          FullOrHalfItem(
                            productModel: product,
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
                              if (fullCartItemQuantity > 0) {
                                BlocProvider.of<CartProductsBloc>(context).add(
                                  AddToCartEvent(
                                    product: CartItemModel(
                                      id: product.id,
                                      categoryId: product.categoryId,
                                      foodType: product.foodType,
                                      itemName: product.itemName,
                                      description: product.description,
                                      price: product.price,
                                      halfPrice: product.halfPrice,
                                      imagePath: product.imagePath,
                                      isHalfItem: false,
                                      quantity: fullCartItemQuantity,
                                    ),
                                  ),
                                );
                              }
                              if (halfCartItemQuantity > 0) {
                                BlocProvider.of<CartProductsBloc>(context).add(
                                  AddToCartEvent(
                                    product: CartItemModel(
                                      id: product.id,
                                      categoryId: product.categoryId,
                                      foodType: product.foodType,
                                      itemName: product.itemName,
                                      description: product.description,
                                      price: product.price,
                                      halfPrice: product.halfPrice,
                                      imagePath: product.imagePath,
                                      isHalfItem: true,
                                      quantity: halfCartItemQuantity,
                                      tax: 0.9,
                                    ),
                                  ),
                                );
                              }
                              fullCartItemQuantity = 0;
                              halfCartItemQuantity = 0;
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
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class FullOrHalfItem extends StatelessWidget {
  FullOrHalfItem({
    Key? key,
    // required this.index,
    required this.state,
    required this.isHalfItem,
    required this.productModel,
  }) : super(key: key);

  // final int index;
  ProductListLoaded state;
  final ProductModel productModel;
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
            ? '₹${productModel.halfPrice}'
            : '₹${productModel.price}'),
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
                  product: productModel,
                  isHalfItem: isHalfItem,
                  itemQuantity: cartState.products.any(
                    (element) =>
                        element.id == productModel.id &&
                        element.isHalfItem == isHalfItem,
                  )
                      ? cartState.products
                          .firstWhere(
                            (element) =>
                                element.id == productModel.id &&
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
    required this.product,
    this.itemQuantity = 0,
    required this.isHalfItem,
  });
  // final int index;
  final ProductModel product;
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
              productItem = widget.product;
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
                                ? halfCartItemQuantity = widget.itemQuantity
                                : fullCartItemQuantity = widget.itemQuantity;
                            BlocProvider.of<CartProductsBloc>(context).add(
                              DecreaseProductQuantityEvent(
                                product: cartState.products.firstWhere(
                                  (element) =>
                                      element.id == productItem.id &&
                                      element.isHalfItem == widget.isHalfItem,
                                ),
                              ),
                            );
                            log('Half Item quantity: $halfCartItemQuantity');
                            return;
                          }
                        }
                        if (widget.itemQuantity > 0) {
                          setState(() {
                            widget.itemQuantity--;
                          });
                          widget.isHalfItem
                              ? halfCartItemQuantity = widget.itemQuantity
                              : fullCartItemQuantity = widget.itemQuantity;
                          log('Half Item quantity: $halfCartItemQuantity');
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
                                ? halfCartItemQuantity = widget.itemQuantity
                                : fullCartItemQuantity = widget.itemQuantity;
                            BlocProvider.of<CartProductsBloc>(context).add(
                              IncreaseProductQuantityEvent(
                                product: cartState.products.firstWhere(
                                  (element) =>
                                      element.id == productItem.id &&
                                      element.isHalfItem == widget.isHalfItem,
                                ),
                              ),
                            );
                            log('Half Item quantity: $halfCartItemQuantity');
                            return;
                          }
                        }
                        setState(() {
                          widget.itemQuantity++;
                        });
                        widget.isHalfItem
                            ? halfCartItemQuantity = widget.itemQuantity
                            : fullCartItemQuantity = widget.itemQuantity;
                        log('Half Item quantity: $halfCartItemQuantity');
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
