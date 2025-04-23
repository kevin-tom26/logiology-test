import 'package:get/get.dart';
import 'package:prodex/core/services/base_service/base_service.dart';
import 'package:prodex/core/storage/local_storage.dart';
import 'package:prodex/routes.dart';

class LogoutService extends BaseService {
  LogoutService() : super();
  void logout() async {
    //LocalData().cleanUp();
    //LocalStorage().clearAll();
    LocalStorage().removeData('isFirstTime');
    Get.offAllNamed(AppRoutes.auth);
  }
}
