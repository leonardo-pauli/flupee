import 'package:flupee/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnail,
    required super.category, 
    required super.brand, 
    required super.discountPercentage, 
    required super.rating, 
    required super.reviews, 
    required super.stockStatus,
  });

  factory ProductModel.fromjson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] as String? ?? '',
      category: json['category'] as String? ?? '', 
      brand: json['brand'] as String? ?? '', 
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0, 
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, 
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((reviewJson) => Review(
                rating: reviewJson['rating'] as int? ?? 0,
                comment: reviewJson['comment'] as String? ?? '',
                reviewerName: reviewJson['reviewerName'] as String? ?? '',
                date: reviewJson['date'] as String? ?? '',
              ))
          .toList() ?? [],
      stockStatus: json['stockStatus'] as String? ?? '',
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
      'brand': brand,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'reviews': reviews,
      'stockStatus': stockStatus,
    };
  }
}
