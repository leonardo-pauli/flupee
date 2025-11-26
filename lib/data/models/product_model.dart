import 'package:flupee/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnail,
    required super.category,
  });

  factory ProductModel.fromjson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      category: json['category'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'thumbnail': thumbnail,
      'category': category,
    };
  }
}
