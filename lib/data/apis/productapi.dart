import "package:dio/dio.dart";
import "package:flexi_quiz/core/constants/apiendpoints.dart" as api;
import "package:flexi_quiz/data/Models/product.dart";
import "package:retrofit/retrofit.dart";

part 'productapi.g.dart';

@RestApi()
abstract class ProductClient{
  factory ProductClient(Dio dio, {String? baseUrl}) = _ProductClient;

  @GET(api.Apiendpoints.products)
  Future<ProductModel> getProducts();

}