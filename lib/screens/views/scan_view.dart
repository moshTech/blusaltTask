import 'package:firebase_auth_with_get_state/controllers/auth_controller.dart';
import 'package:firebase_auth_with_get_state/controllers/scan_controller.dart';
import 'package:firebase_auth_with_get_state/screens/widgets/scan_card.dart';
import 'package:firebase_auth_with_get_state/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:blinkid_flutter/microblink_scanner.dart';
import 'package:get/get.dart';

class ScanView extends GetWidget<AuthController> {
  // final AuthController controller = Get.find();
  String _resultString = "";
  String fullName = "";
  String address = '',
      docNum = '',
      sex = '',
      dob = '',
      age = '',
      dateIssue = '',
      expryPerm = '',
      proffesion = '';

  Future<void> scan() async {
    String license;
    if (Get.theme.platform == TargetPlatform.iOS) {
      license = '';
    } else if (Get.theme.platform == TargetPlatform.android) {
      license =
          'sRwAAAAlY29tLm1vc2guZmlyZWJhc2VfYXV0aF93aXRoX2dldF9zdGF0ZXoEDMzzYLW2fMeJMgwUTMzuWMhbiDmXexydHBoIi/G7x/Jg9QBzdCSdjrcdH4m/jrpBzQKOl9t6/oHDN2swC35b2x5DqSXn4chvcbTpdETV7IbRheTbCYfCcQwzAwNy+2CZzJGKUnSK0z7L80xLTgT8Dpbdyn1FuzZkkL4mNKcsVFcRW0P0ike60AAvedaIYrQu9lvYBnSOgbkuFThVRENRm9KLwDMvJgyPNoQnNICiR0rOZko/e+A580qbPDvWnOUJPlfPdIo=';
    }

    var idRecognizer = BlinkIdCombinedRecognizer();
    idRecognizer.returnFullDocumentImage = true;
    idRecognizer.returnFaceImage = true;

    BlinkIdOverlaySettings settings = BlinkIdOverlaySettings();

    var results = await MicroblinkScanner.scanWithCamera(
        RecognizerCollection([idRecognizer]), settings, license);

    // if (!mounted) return;

    if (results.length == 0) return;
    for (var result in results) {
      if (result is BlinkIdCombinedRecognizerResult) {
        if (result.mrzResult.documentType == MrtdDocumentType.Passport) {
          _resultString = '';
        } else {
          _resultString = '';
        }

        // _resultString = _resultString;

        fullName = buildResult(result.firstName, "First name") +
            buildResult(result.lastName, "Last name") +
            buildResult(result.fullName, "Full name") +
            buildResult(result.localizedName, "Localized name");
        address = buildResult(result.address, "Address");
        docNum = buildResult(result.documentNumber, "Document number") +
            buildResult(
                result.documentAdditionalNumber, "Additional document number");
        sex = buildResult(result.sex, "Sex");
        dob = buildDateResult(result.dateOfBirth, "Date of birth");
        age = buildIntResult(result.age, "Age");
        dateIssue = buildDateResult(result.dateOfIssue, "Date of issue");
        expryPerm = buildResult(result.dateOfExpiryPermanent.toString(),
            "Date of expiry permanent");
        proffesion = buildResult(result.profession, "Profession");

        return;
      }
    }
  }

  String buildResult(String result, String propertyName) {
    if (result == null || result.isEmpty) {
      return "";
    }

    return result;
  }

  String buildDateResult(Date result, String propertyName) {
    if (result == null || result.year == 0) {
      return "";
    }

    return buildResult(
        "${result.day}.${result.month}.${result.year}", propertyName);
  }

  String buildIntResult(int result, String propertyName) {
    if (result < 0) {
      return "";
    }

    return buildResult(result.toString(), propertyName);
  }

  String buildDriverLicenceResult(DriverLicenseDetailedInfo result) {
    if (result == null) {
      return "";
    }

    return buildResult(result.restrictions, "Restrictions") +
        buildResult(result.endorsements, "Endorsements") +
        buildResult(result.vehicleClass, "Vehicle class") +
        buildResult(result.conditions, "Conditions");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned documents"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.logout();
            },
          ),
          IconButton(
            icon: Icon(Icons.nightlight_round),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GetX<ScanController>(
          init: Get.put<ScanController>(ScanController()),
          builder: (ScanController scanController) {
            if (scanController != null && scanController.scans != null) {
              return ListView.builder(
                itemCount: scanController.scans.length,
                itemBuilder: (_, index) {
                  return ScanCard(
                      uid: controller.currentUser.id,
                      scan: scanController.scans[index]);
                },
              );
            } else {
              return Text("loading...");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await scan();
          FirestoreService().addScan(
              fullName: fullName,
              uid: controller.currentUser.id,
              address: address,
              docNumber: docNum,
              sex: sex,
              dob: dob,
              // dateIssue: dateIssue,
              // age: age,
              expPerm: expryPerm,
              profession: proffesion);
        },
        label: Text('Scan'),
        icon: Icon(Icons.scanner_sharp),
      ),
    );
  }
}
