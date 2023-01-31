import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_bigplate/logic/blocs/cart_products/cart_products_bloc.dart';
import 'package:my_bigplate/logic/blocs/category_products/category_products_bloc.dart';
import 'package:my_bigplate/logic/blocs/product_list/product_list_bloc.dart';
import 'package:my_bigplate/presentation/screens/categories/item_categories.dart';
import 'package:my_bigplate/presentation/utils/colors/app_colors.dart';
import 'package:my_bigplate/resources/repositories/cart_repository.dart';
import 'package:my_bigplate/resources/repositories/categories_repository.dart';
import 'package:my_bigplate/resources/repositories/product_list_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryProductsBloc>(
          create: (context) => CategoryProductsBloc(CategoryRepository()),
        ),
        BlocProvider<ProductListBloc>(
          create: (context) => ProductListBloc(ProductlistRepository()),
        ),
        BlocProvider<CartProductsBloc>(
          create: (context) =>
              CartProductsBloc(CartRepository())..add(LoadCartProducts()),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          theme: ThemeData(
            primaryColor: AppColors.colorPrimary,
            // primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(body: home(mediaQuery: _mediaQuery));
  }
}

class home extends StatelessWidget {
  home({
    Key? key,
    required MediaQueryData mediaQuery,
  })  : _mediaQuery = mediaQuery,
        super(key: key);

  final MediaQueryData _mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          //==================================Potrait=============================================================

          if (_mediaQuery.orientation == Orientation.portrait) {
            return Container(
              width: _mediaQuery.size.width * 1,
              height: _mediaQuery.size.height * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: _mediaQuery.size.height * .3,
                      width: _mediaQuery.size.width * .6,
                      child: Image.asset("assets/images/logowob.png")),
                  Image.asset("assets/images/homev.jpg"),
                  Text(
                    "Giving your Hunger new Options",
                    style: TextStyle(
                        fontFamily: "Mansory",
                        fontWeight: FontWeight.bold,
                        fontSize: _mediaQuery.size.width * .05),
                  ),
                  const Text(""),
                ],
              ),
            );
          }

          //==================================Landscape=============================================================

          else {
            return Container(
              width: _mediaQuery.size.width * 1,
              height: _mediaQuery.size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: _mediaQuery.size.height * .28,
                      child: Image.asset("assets/images/logowob.png")),
                  SizedBox(
                      width: _mediaQuery.size.width * .7,
                      height: _mediaQuery.size.height * .40,
                      child: Image.asset(
                        "assets/images/homev.jpg",
                        fit: BoxFit.fill,
                      )),
                  const Text(
                    "Giving your Hunger new Options",
                    style: TextStyle(
                        fontFamily: "Mansory",
                        fontWeight: FontWeight.bold,
                        fontSize: 34),
                  ),
                  const Text(""),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
            );
          }
        }),
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          boxShadow: [
            BoxShadow(
                color: Colors.orange.shade200, spreadRadius: 3, blurRadius: 5)
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 10,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ItemCategories(),
                ));
          },
          child: const Icon(
            FontAwesomeIcons.arrowRight,
            color: Color.fromARGB(255, 246, 165, 59),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const SizedBox(
        height: 120,
        child: BottomAppBar(
            color: Color.fromARGB(255, 242, 160, 52),
            shape: CircularNotchedRectangle(),
            notchMargin: 15,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Mansory",
                      fontSize: 20,
                    ),
                  ),
                ))),
      ),
    );
  }
}
