class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image
});

  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;


  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: (json["price"] is int) ? (json["price"] as int).toDouble() : json["price"],
    category: json["category"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "category": category,
    "description": description,
    "image": image,
  };
}