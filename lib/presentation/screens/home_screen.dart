import 'package:flupee/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) =>  HomeScreen(),
              ),
              );
        }, 
        child: const Text(
          'Flupee Store', 
          style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ),
        backgroundColor: const Color(0xFF006666),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              'assets/images/flupee.png',
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            iconSize: 24,
            tooltip: 'Carrinho',
          ),
        ],
      ),
      // O método .when() trata magicamente os 3 estados possíveis de uma chamada assíncrona
      body: productsAsync.when(
        // 1. Estado de Carregamento
        loading: () => const Center(child: CircularProgressIndicator()),
        
        // 2. Estado de Erro
        error: (err, stack) => Center(child: Text('Erro: $err')),
        
        // 3. Estado de Sucesso (Data) - Aqui temos a lista de produtos pronta
        data: (products) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // Largura máxima de cada card
              childAspectRatio: 0.7,   // Proporção altura/largura
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias, // Corta a imagem nas bordas arredondadas
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagem do Produto
                      Expanded(
                        child: Image.network(
                          product.thumbnail,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(color: Colors.grey[200]); 
                          },
                          errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.broken_image),
                        ),
                      ),
                      // Informações
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'R\$ ${product.price}',
                              style: const TextStyle(
                                color: Color(0xFF006666), 
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}