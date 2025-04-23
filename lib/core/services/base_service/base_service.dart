import 'package:prodex/core/module/network_module/network_module.dart';
import 'package:dio/dio.dart';

class BaseService {
  late Dio dioClient;

  BaseService() {
    dioClient = NetworkModule().provideDio();
  }
}
