import 'package:firebase_auth_with_get_state/controllers/bindings/app_bindings.dart';
import 'package:firebase_auth_with_get_state/screens/views/login_view.dart';
import 'package:firebase_auth_with_get_state/screens/views/signup_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const HOME = Routes.HOME;
  static const SECOND = Routes.SECOND;
  static const INITIAL = Routes.LOGIN;
  static const SIGNUP = Routes.SIGNUP;

  static final routes = [
    GetPage(
      name: INITIAL,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: SIGNUP,
      page: () => SignupView(),
    ),
  ];
}
