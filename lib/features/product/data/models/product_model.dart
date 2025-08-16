import 'package:hive/hive.dart';
import 'package:mini_ecommerce/features/product/domain/entities/product.dart';

part 'product_model.g.dart'; // build_runner se generate hoga

@HiveType(typeId: 0) // unique typeId
class ProductModel extends Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final double price;
  @HiveField(5)
  final String? localImagePath;

  const ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    this.localImagePath,
  }) : super(
          id: id,
          title: title,
          image: image,
          description: description,
          price: price,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int,
        title: json['title'] as String,
        image: json['image'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        localImagePath: json['localImagePath'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'description': description,
        'price': price,
        'localImagePath': localImagePath,
      };
}
