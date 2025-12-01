import 'package:flupee/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildWebLayout(context);
          } else {
            return _buildMobilelayout(context);
          }
        },
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(blurRadius: 20, color: Colors.black12),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Hero(
                        tag: 'product_${product.id}',
                        child: Image.network(
                          product.thumbnail,
                          fit: BoxFit.contain,
                          height: 500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 40),

                Expanded(flex: 4, child: _buildBuyBox(context)),
              ],
            ),

            const SizedBox(height: 60),
            const Divider(),
            const SizedBox(height: 30),

            Text(
              'Descrição do Produto',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 60),
            const Divider(),
            const SizedBox(height: 30),

            Text(
              'Comentários',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...product.reviews.map((review) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        review.reviewerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildStarRating(review.rating.toDouble()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review.comment,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    review.date,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobilelayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: 300,
            width: double.infinity,
            child: Hero(
              tag: 'product_${product.id}',
              child: Image.network(product.thumbnail, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBuyBox(context),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 20),

                Text(
                  "Descrição",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.brand.toUpperCase(),
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          product.title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),

        Row(
          children: [
            _buildStarRating(product.rating),
            SizedBox(width: 8),
            Text(
              "${product.rating} | ${product.reviews.length} avaliações",
              style: TextStyle(color: Colors.blueGrey, fontSize: 14),
            ),
          ],
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'R\$ ${product.price}',
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF006666),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 12),
            if (product.discountPercentage > 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '-${product.discountPercentage}\$ OFF',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),

        Text(
          product.stockStatus,
          style: TextStyle(
            color: product.stockStatus.contains('Low')
                ? Colors.orange
                : Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF006666),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Adicionado ao Carrinho')));
            },
            icon: Icon(Icons.shopping_bag_outlined),
            label: Text(
              'ADICIONAR AO CARRINHO',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        bool isSelected = index < rating.round();
        return Icon(
          isSelected ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }
}
