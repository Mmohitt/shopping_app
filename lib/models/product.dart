import 'package:e_comm_app/models/rating.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'product.freezed.dart';
part 'product.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Product with _$Product {
    factory Product({
    required int id,
    required String title,
    required double price,
    required String category,
    required String description,
    required String image,
    required Rating rating,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

