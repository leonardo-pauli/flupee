import 'dart:convert';

import 'package:flupee/data/models/product_model.dart';
import 'package:flupee/domain/entities/product.dart';
import 'package:http/http.dart' as http;


class ProductRepository {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts() async {
    try{
      final  response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {

        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        final List<dynamic> productsList = jsonResponse['products'];

        return productsList.map((e) => ProductModel.fromjson(e)).toList();
      }else{
      throw Exception('Erro ao carregar os produtos. Código: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}