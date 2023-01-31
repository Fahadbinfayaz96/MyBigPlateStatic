// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String id;
  final String categoryId;
  final String foodType;
  final String itemName;
  final String description;
  final double price;
  final double halfPrice;
  final String imagePath;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.foodType,
    required this.itemName,
    required this.description,
    required this.price,
    required this.halfPrice,
    this.imagePath = '',
  });
}
