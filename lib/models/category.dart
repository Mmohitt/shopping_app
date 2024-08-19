
class Category {
  const Category({
    required this.name,
  });

  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"] as String,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
