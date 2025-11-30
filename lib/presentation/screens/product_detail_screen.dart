import 'package:flupee/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if(constraints.maxWidth > 800) {
          return _buildWebLayout(context);
        }else{
          return Text('oi');
        }
      }),
    );
  }


  Widget _buildWebLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5, 
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black12)],
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

          Expanded(
            flex: 4, // Ocupa 40% do espaço
            child: _buildProductInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilelayout(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: 'product_${product.id}', 
            child: Image.network(
              product.thumbnail,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ),
            Padding(padding: EdgeInsets.all(16),
            child: _buildProductInfo(context),),
        ],
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Chip(
          label: Text(product.category.toUpperCase()),
          backgroundColor: const Color(0xFF006666).withOpacity(0.1),
          labelStyle: const TextStyle(color: Color(0xFF006666), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          product.title,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'R\$ ${product.price}',
          style: const TextStyle(
            fontSize: 28,
            color: Color(0xFF006666),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          product.description,
          style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 32),
        // Botão de Ação
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006666),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Adicionado ao carrinho (Lógica em breve!)')),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('ADICIONAR AO CARRINHO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}