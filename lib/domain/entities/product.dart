class Review{
  final int rating;
  final String comment;
  final String reviewerName;
  final String date;

  Review({
    required this.date,
    required this.rating,
    required this.comment,
    required this.reviewerName,
  });
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final String category;
  final double discountPercentage;
  final double rating;
  final String stockStatus;
  final String brand;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.category,
    required this.brand,
    required this.discountPercentage,
    required this.rating,
    required this.reviews,
    required this.stockStatus,
  });
}
