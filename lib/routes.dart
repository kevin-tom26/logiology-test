import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:prodex/features/auth/ui/screen/auth_screen.dart';
import 'package:prodex/features/product_details/ui/screen/product_detail.dart';
import 'package:prodex/features/product_home/ui/screen/product_home.dart';
import 'package:prodex/features/profile/ui/screen/profile.dart';
import 'package:prodex/features/splash/ui/screen/splash.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String product = '/product';
  //static const String filter = '/filter';
  static const String productDetail = '/product-detail';
  static const String profile = '/profile';

  static final List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: auth, page: () => AuthScreen()),
    GetPage(name: product, page: () => ProductScreen()),
    // GetPage(name: filter, page: () => FilterScreen()),
    GetPage(name: productDetail, page: () => const ProductDetailScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
  ];
}
