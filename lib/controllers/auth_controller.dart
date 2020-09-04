import 'package:firebase_auth_with_get_state/models/user.dart';
import 'package:firebase_auth_with_get_state/screens/views/login_view.dart';
import 'package:firebase_auth_with_get_state/screens/views/scan_view.dart';
import 'package:firebase_auth_with_get_state/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

enum Status { loading, success, error, initialising }

class AuthController extends GetxController {
  final AuthService authService;

  AuthController({this.authService});

  UserModel get currentUser => authService.currentUser;

  final status = Status.initialising.obs;

  Future login({@required String email, @required String password}) async {
    status(Status.loading);

    var result =
        await authService.loginWithEmail(email: email, password: password);
    status(Status.success);

    if (result is bool) {
      if (result) {
        Get.off(ScanView());
      } else {
        Get.snackbar('Login Failure',
            'Couldn\'t login at this moment. Please try again later');
      }
    } else if (result.toString().contains('An internal error has occurred.')) {
      Get.snackbar('Login Failure',
          'No internet connection. Check your internet connection and try again.');
    } else {
      Get.snackbar('Login Failure', result);
    }
  }

  Future signup(
      {@required String email,
      @required String name,
      @required String password}) async {
    status(Status.loading);

    var result = await authService.registerWithEmail(
        email: email, password: password, name: name);

    status(Status.success);

    if (result is bool) {
      if (result) {
        Get.off(ScanView());
      } else {
        Get.snackbar('Signup Failure',
            'Couldn\'t Signup at this moment. Please try again later');
      }
    } else if (result.toString().contains('An internal error has occurred.')) {
      Get.snackbar('Signup Failure',
          'No internet connection. Check your internet connection and try again.');
    } else {
      Get.snackbar('Signup Failure', result);
    }
  }

  void logout() {
    Get.off(LoginView());
    authService.signOut();
  }
}
