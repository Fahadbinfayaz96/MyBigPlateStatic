import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_bigplate/logic/blocs/category_products/category_products_bloc.dart';
import 'package:my_bigplate/presentation/widgets/banner_widget.dart';
import 'package:my_bigplate/presentation/screens/product_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCategories extends StatelessWidget {
  const ItemCategories({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryProductsBloc>(context).add(LoadCategoryProducts());
    return Scaffold(body: OrientationBuilder(
      builder: (context, orientation) {
        return BlocBuilder<CategoryProductsBloc, CategoryProductsState>(
          builder: (context, state) {
            if (state is CategoryProductsLoaded) {
              return Column(
                children: [
                  const BannerWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 14,
                      ),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, top: 6, bottom: 18),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 240, 186, 104),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(state
                                                .categoryItems[index].image),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(.6),
                                              BlendMode.hardLight,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: SizedBox(
                                        child: Text(
                                          state
                                              .categoryItems[index].categoryName
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Mansory',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductList(
                                    categoryId: state.categoryItems[index].id,
                                    categoryName:
                                        state.categoryItems[index].categoryName,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        itemCount: state.categoryItems.length,
                      ),
                    ),
                  )
                ],
              );
            }
            return const SizedBox(
              child: Center(
                child: Text('Helooo'),
              ),
            );
          },
        );
      },
    ));
  }
}
