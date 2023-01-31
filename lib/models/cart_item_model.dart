// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  final String id;
  final String categoryId;
  final String foodType;
  final String itemName;
  final String description;
  final double price;
  final double halfPrice;
  final String imagePath;
  final double tax;
  int quantity;
  final bool isHalfItem;
  CartItemModel({
    required this.id,
    required this.categoryId,
    required this.foodType,
    required this.itemName,
    required this.description,
    required this.price,
    required this.halfPrice,
    required this.imagePath,
    this.quantity = 0,
    this.tax = 0.0,
    required this.isHalfItem,
  });
  CartItemModel copyWith({
    String? id,
    String? categoryId,
    String? foodType,
    String? itemName,
    String? description,
    double? price,
    double? halfPrice,
    String? imagePath,
    int? quantity,
  }) {
    return CartItemModel(
      id: this.id,
      categoryId: this.categoryId,
      foodType: this.foodType,
      itemName: this.itemName,
      description: this.description,
      price: this.price,
      halfPrice: this.halfPrice,
      imagePath: this.imagePath,
      isHalfItem: isHalfItem,
      quantity: this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        id,
        categoryId,
        foodType,
        itemName,
        description,
        price,
        halfPrice,
        imagePath,
        isHalfItem,
        quantity,
      ];
}
