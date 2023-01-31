import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_bigplate/logic/blocs/product_list/product_list_bloc.dart';
import 'package:my_bigplate/presentation/screens/cart.dart';
import 'package:my_bigplate/presentation/screens/product_detail_screen.dart';
import 'package:my_bigplate/presentation/utils/my_icons.dart';
import 'package:my_bigplate/presentation/widgets/dialog_widget.dart';

class ProductList extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const ProductList({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    BlocProvider.of<ProductListBloc>(context).add(LoadProductList(categoryId));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text(
          categoryName,
          style: TextStyle(
            fontFamily: 'Mansory',
            color: Colors.white,
            fontSize: _mediaQuery.size.longestSide * .03,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoaded) {
            return ListView.builder(
              itemCount: state.productList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    productModel: state.productList[index],
                  ),
                )),
                child: Column(
                  children: [
                    Container(
                      height: _mediaQuery.size.height * .16,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 239, 183, 110),
                            blurRadius: 2,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: _mediaQuery.size.height,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)),
                              child: Image.asset(
                                "assets/images/platters.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      state.productList[index].foodType == "veg"
                                          ? Icon(
                                              MyIcons.veg,
                                              color: Colors.green,
                                              size:
                                                  _mediaQuery.size.width * .02,
                                            )
                                          : Icon(
                                              MyIcons.veg,
                                              color: Colors.red,
                                              size:
                                                  _mediaQuery.size.width * .02,
                                            ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.productList[index].itemName,
                                          style: const TextStyle(
                                              fontFamily: 'Mansory',
                                              fontSize: 16.2,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.productList[index].description,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontFamily: 'Mansory',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  state.productList[index].price.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Mansory',
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent,
                                      shadowColor: const Color.fromARGB(
                                          255, 215, 149, 63),
                                      elevation: 4),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (
                                        BuildContext context,
                                      ) {
                                        return Center(
                                          child: DialogWidget(index: index),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(
                                      fontFamily: "Mansory",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text('Loading...'),
          );
        },
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
          child: const Icon(
            FontAwesomeIcons.cartShopping,
            size: 28,
            color: Colors.orange,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const SizedBox(
        height: 76,
        child: BottomAppBar(
          color: Colors.orange,
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
        ),
      ),
    );
  }
}
