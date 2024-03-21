import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final String? image;
  final double? price;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        image,
        price,
      ];
}
