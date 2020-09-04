import 'package:firebase_auth_with_get_state/models/scan.dart';
import 'package:firebase_auth_with_get_state/services/firestore_service.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class ScanController extends GetxController {
  Rx<List<ScanModel>> scanList = Rx<List<ScanModel>>();

  List<ScanModel> get scans => scanList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().currentUser.id;
    scanList.bindStream(
        FirestoreService().scanStream(uid)); //stream coming from firebase
  }
}
