import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_bigplate/logic/blocs/cart_products/cart_products_bloc.dart';
import 'package:my_bigplate/main.dart';
import 'package:my_bigplate/presentation/widgets/cart_item.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    var _mediaQueryyy = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<CartProductsBloc, CartProductsState>(
        builder: (context, state) {
          if (state is CartProductsLoaded) {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CartItem(
                          cartState: state,
                          index: index,
                        );
                      },
                      itemCount: state.products.length,
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            spreadRadius: 3)
                      ],
                    ),
                    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item Total",
                              style: TextStyle(fontFamily: "Mansory"),
                            ),
                            Text("${state.totalAmount.itemTotal}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tax",
                              style: TextStyle(fontFamily: "Mansory"),
                            ),
                            Text("${state.totalAmount.tax}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("To Pay"),
                            Text(
                              "${state.totalAmount.totalAmount}",
                              style: TextStyle(fontFamily: "Mansory"),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            );
          }
          return const SizedBox();
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
                builder: (context) => home(
                  mediaQuery: _mediaQueryyy,
                ),
              ),
            );
          },
          child: Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: Icon(
                FontAwesomeIcons.home,
                size: 40,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
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
