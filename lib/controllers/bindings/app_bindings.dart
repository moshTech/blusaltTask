import 'package:firebase_auth_with_get_state/controllers/auth_controller.dart';
import 'package:firebase_auth_with_get_state/controllers/scan_controller.dart';
import 'package:firebase_auth_with_get_state/services/auth_service.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.put<AuthController>(AuthController(authService: Get.find()),
        permanent: true);
    Get.lazyPut(() => ScanController());
  }
}
