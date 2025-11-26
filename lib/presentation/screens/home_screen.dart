import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // O ref.watch fica "olhando" o provider. 
    // Se o estado mudar (de carregando para sucesso), a tela redesenha sozinha.
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flupee Store'),
        backgroundColor: const Color(0xFF006666), // Cor primária definida por você
        foregroundColor: Colors.white,
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
              return Card(
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
                          return Container(color: Colors.grey[200]); // Placeholder simples
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
              );
            },
          );
        },
      ),
    );
  }
}