import 'package:dio/dio.dart';
import 'package:prodex/core/model/rest_response.dart';
import 'package:prodex/core/services/base_service/base_service.dart';
import 'package:prodex/utils/config_colection/config/config.dart';

class ProductService extends BaseService {
  ProductService() : super();

  Future<RestResponse> getAllProducts(int pageNo) async {
    String url = '${Config.baseUrl}?limit=10&skip=${10 * pageNo}';

    try {
      final Response response = await dioClient.get(url,
          options: Options(contentType: 'application/json; charset=utf-8'));
      if (response.statusCode == 200) {
        return RestResponse(
            apiSuccess: true,
            message: response.statusMessage,
            statusCode: response.statusCode,
            data: response.data);
      } else {
        return RestResponse(
            message: response.statusMessage,
            statusCode: response.statusCode,
            data: response.data);
      }
    } on DioException catch (e) {
      return RestResponse(
        message: e.message,
        apiSuccess: false,
      );
    }
  }

  Future<RestResponse> getCategoriesList() async {
    const String url = '${Config.baseUrl}/category-list';

    try {
      final Response response = await dioClient.get(url,
          options: Options(contentType: 'application/json; charset=utf-8'));
      if (response.statusCode == 200) {
        return RestResponse(
            apiSuccess: true,
            message: response.statusMessage,
            statusCode: response.statusCode,
            data: response.data);
      } else {
        return RestResponse(
            message: response.statusMessage,
            statusCode: response.statusCode,
            data: response.data);
      }
    } on DioException catch (e) {
      return RestResponse(
        message: e.message,
        apiSuccess: false,
      );
    }
  }
}
