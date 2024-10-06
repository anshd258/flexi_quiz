import 'package:flexi_quiz/core/constants/dio.dart';
import 'package:flexi_quiz/core/constants/typedef.dart';
import 'package:flexi_quiz/core/log/logger.dart';
import 'package:flexi_quiz/data/Models/product.dart';
import 'package:flexi_quiz/data/apis/productapi.dart';
import 'package:fpdart/fpdart.dart';

class ProductRepository {
  Future<ResponseEither<ProductModel>> getProducts() async {
    try {
      final response = await ProductClient(dio).getProducts();
      return Right(response);
    } catch (e) {
      talker.error(e.toString());
      return Left(e.toString());
    }
  }
}
