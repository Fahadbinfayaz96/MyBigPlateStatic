import 'package:my_bigplate/models/category_model.dart';

class CategoryRepository {
  final List<CategoriesModel> _item = [
    CategoriesModel(
      id: "p1",
      categoryName: "Coffee",
      image: "assets/images/coffee.png",
    ),
    CategoriesModel(
      id: "p2",
      categoryName: "All Day Breakfast",
      image: "assets/images/all-day-breakfast.png",
    ),
    CategoriesModel(
      id: "p3",
      categoryName: "Sandwich",
      image: "assets/images/sandwich.png",
    ),
    CategoriesModel(
      id: "p4",
      categoryName: "Blended Smoothies",
      image: "assets/images/blneded.jpg",
    ),
    CategoriesModel(
      id: "p5",
      categoryName: "Pizza",
      image: "assets/images/pizza.png",
    ),
    CategoriesModel(
      id: "p6",
      categoryName: "Wraps",
      image: "assets/images/wraps.png",
    ),
    CategoriesModel(
      id: "p7",
      categoryName: "Platters",
      image: "assets/images/platters.jpg",
    ),
    CategoriesModel(
      id: "p8",
      categoryName: "Drinks",
      image: "assets/images/drinks.png",
    ),
    CategoriesModel(
      id: "p9",
      categoryName: "Hot Chocolate",
      image: "assets/images/hot-chocolate.jpg",
    ),
    CategoriesModel(
      id: "p10",
      categoryName: "Classic Tea",
      image: "assets/images/classic-tea.png",
    ),
    CategoriesModel(
      id: "p11",
      categoryName: "Fresh Juice And Blends",
      image: "assets/images/juic.jpg",
    ),
    CategoriesModel(
      id: "p12",
      categoryName: "Teas",
      image: "assets/images/tea.png",
    ),
    CategoriesModel(
      id: "p13",
      categoryName: "Bread",
      image: "assets/images/bread.png",
    ),
    CategoriesModel(
      id: "p14",
      categoryName: "Smoothies",
      image: "assets/images/smoothie.png",
    ),
    CategoriesModel(
      id: "p15",
      categoryName: "Salads",
      image: "assets/images/salad.png",
    ),
    CategoriesModel(
      id: "p16",
      categoryName: "Soup",
      image: "assets/images/soup.png",
    ),
    CategoriesModel(
      id: "p17",
      categoryName: "Pancakes And Waffles",
      image: "assets/images/pancakes.png",
    ),
    CategoriesModel(
      id: "p18",
      categoryName: "Time Killing Snacks",
      image: "assets/images/snacks.png",
    ),
    CategoriesModel(
      id: "p19",
      categoryName: "Burger",
      image: "assets/images/burger.png",
    ),
    CategoriesModel(
      id: "p20",
      categoryName: "Pasta",
      image: "assets/images/pasta.jpg",
    ),
  ];
  List<CategoriesModel> get items {
    return [..._item];
  }
}
