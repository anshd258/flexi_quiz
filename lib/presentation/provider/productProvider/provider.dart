import 'package:flexi_quiz/core/constants/typedef.dart';
import 'package:flexi_quiz/data/Models/product.dart';
import 'package:flexi_quiz/presentation/provider/productProvider/repository/repository.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{

  ProductProvider({required this.apirepository});
  
  ProductRepository apirepository;

  ResponseEither<ProductModel>? _products;
  ResponseEither<ProductModel>? get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

   Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    final result = await apirepository.getProducts();

    _products = result;
    _isLoading = false;
    notifyListeners();
  }
}