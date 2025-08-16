class Product {
  final int id;
  final String title;
  final String image;
  final String description;
  final double price;
  final String? localImagePath;

  const Product({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
     this.localImagePath,
  });
}