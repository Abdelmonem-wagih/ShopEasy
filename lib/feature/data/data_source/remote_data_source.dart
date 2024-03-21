import 'package:dio/dio.dart';
import 'package:shopease/core/exeption/exception.dart';
import 'package:shopease/core/network/error_message_model.dart';
import 'package:shopease/core/unit/app_constance.dart';
import 'package:shopease/feature/data/models/product_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<ProductModel>> getProduct();
}

class RemoteDataSource extends BaseRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<List<ProductModel>> getProduct() async {
    final response =
        await dio.get(AppConstance.baseUrl);
    if (response.statusCode == 200) {
      return List<ProductModel>.from(
          (response.data as List).map((e) => ProductModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJason(response.data));
    }
  }
}
