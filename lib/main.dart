import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'shared/logger/logger_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: Logger.write,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.dark(),
    );
  }
}

// import 'package:blinkid_flutter/microblink_scanner.dart';
// import 'package:flutter/material.dart';
// import "dart:convert";
// import "dart:async";

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
// String _resultString = "";
// String _fullDocumentFrontImageBase64 = "";
// String _fullDocumentBackImageBase64 = "";
// String _faceImageBase64 = "";

// Future<void> scan() async {
//   String license;
//   if (Theme.of(context).platform == TargetPlatform.iOS) {
//     license = '';
//   } else if (Theme.of(context).platform == TargetPlatform.android) {
//     license =
//         'sRwAAAAlY29tLm1vc2guZmlyZWJhc2VfYXV0aF93aXRoX2dldF9zdGF0ZXoEDMzzYLW2fMeJMgwUTMzuWMhbiDmXexydHBoIi/G7x/Jg9QBzdCSdjrcdH4m/jrpBzQKOl9t6/oHDN2swC35b2x5DqSXn4chvcbTpdETV7IbRheTbCYfCcQwzAwNy+2CZzJGKUnSK0z7L80xLTgT8Dpbdyn1FuzZkkL4mNKcsVFcRW0P0ike60AAvedaIYrQu9lvYBnSOgbkuFThVRENRm9KLwDMvJgyPNoQnNICiR0rOZko/e+A580qbPDvWnOUJPlfPdIo=';
//   }

//   var idRecognizer = BlinkIdCombinedRecognizer();
//   idRecognizer.returnFullDocumentImage = true;
//   idRecognizer.returnFaceImage = true;

//   BlinkIdOverlaySettings settings = BlinkIdOverlaySettings();

//   var results = await MicroblinkScanner.scanWithCamera(
//       RecognizerCollection([idRecognizer]), settings, license);

//   if (!mounted) return;

//   if (results.length == 0) return;
//   for (var result in results) {
//     if (result is BlinkIdCombinedRecognizerResult) {
//       if (result.mrzResult.documentType == MrtdDocumentType.Passport) {
//         _resultString = getPassportResultString(result);
//       } else {
//         _resultString = getIdResultString(result);
//       }

//       setState(() {
//         _resultString = _resultString;
//         _fullDocumentFrontImageBase64 = result.fullDocumentFrontImage;
//         _fullDocumentBackImageBase64 = result.fullDocumentBackImage;
//         _faceImageBase64 = result.faceImage;
//       });

//       return;
//     }
//   }
// }

// String getIdResultString(BlinkIdCombinedRecognizerResult result) {
//   return buildResult(result.firstName, "First name") +
//       buildResult(result.lastName, "Last name") +
//       buildResult(result.fullName, "Full name") +
//       buildResult(result.localizedName, "Localized name") +
//       buildResult(result.additionalNameInformation, "Additional name info") +
//       buildResult(result.address, "Address") +
//       buildResult(
//           result.additionalAddressInformation, "Additional address info") +
//       buildResult(result.documentNumber, "Document number") +
//       buildResult(
//           result.documentAdditionalNumber, "Additional document number") +
//       buildResult(result.sex, "Sex") +
//       buildResult(result.issuingAuthority, "Issuing authority") +
//       buildResult(result.nationality, "Nationality") +
//       buildDateResult(result.dateOfBirth, "Date of birth") +
//       buildIntResult(result.age, "Age") +
//       buildDateResult(result.dateOfIssue, "Date of issue") +
//       buildDateResult(result.dateOfExpiry, "Date of expiry") +
//       buildResult(result.dateOfExpiryPermanent.toString(),
//           "Date of expiry permanent") +
//       buildResult(result.maritalStatus, "Martial status") +
//       buildResult(result.personalIdNumber, "Personal Id Number") +
//       buildResult(result.profession, "Profession") +
//       buildResult(result.race, "Race") +
//       buildResult(result.religion, "Religion") +
//       buildResult(result.residentialStatus, "Residential Status") +
//       buildDriverLicenceResult(result.driverLicenseDetailedInfo);
// }

// String buildResult(String result, String propertyName) {
//   if (result == null || result.isEmpty) {
//     return "";
//   }

//   return propertyName + ": " + result + "\n";
// }

// String buildDateResult(Date result, String propertyName) {
//   if (result == null || result.year == 0) {
//     return "";
//   }

//   return buildResult(
//       "${result.day}.${result.month}.${result.year}", propertyName);
// }

// String buildIntResult(int result, String propertyName) {
//   if (result < 0) {
//     return "";
//   }

//   return buildResult(result.toString(), propertyName);
// }

// String buildDriverLicenceResult(DriverLicenseDetailedInfo result) {
//   if (result == null) {
//     return "";
//   }

//   return buildResult(result.restrictions, "Restrictions") +
//       buildResult(result.endorsements, "Endorsements") +
//       buildResult(result.vehicleClass, "Vehicle class") +
//       buildResult(result.conditions, "Conditions");
// }

// String getPassportResultString(BlinkIdCombinedRecognizerResult result) {
//   var dateOfBirth = "";
//   if (result.mrzResult.dateOfBirth != null) {
//     dateOfBirth = "Date of birth: ${result.mrzResult.dateOfBirth.day}."
//         "${result.mrzResult.dateOfBirth.month}."
//         "${result.mrzResult.dateOfBirth.year}\n";
//   }

//   var dateOfExpiry = "";
//   if (result.mrzResult.dateOfExpiry != null) {
//     dateOfExpiry = "Date of expiry: ${result.mrzResult.dateOfExpiry.day}."
//         "${result.mrzResult.dateOfExpiry.month}."
//         "${result.mrzResult.dateOfExpiry.year}\n";
//   }

//   return "First name: ${result.mrzResult.secondaryId}\n"
//       "Last name: ${result.mrzResult.primaryId}\n"
//       "Document number: ${result.mrzResult.documentNumber}\n"
//       "Sex: ${result.mrzResult.gender}\n"
//       "$dateOfBirth"
//       "$dateOfExpiry";
// }

// @override
// Widget build(BuildContext context) {
//   Widget fullDocumentFrontImage = Container();
//   if (_fullDocumentFrontImageBase64 != null &&
//       _fullDocumentFrontImageBase64 != "") {
//     fullDocumentFrontImage = Column(
//       children: <Widget>[
//         Text("Document Front Image:"),
//         Image.memory(
//           Base64Decoder().convert(_fullDocumentFrontImageBase64),
//           height: 180,
//           width: 350,
//         )
//       ],
//     );
//   }

//   Widget fullDocumentBackImage = Container();
//   if (_fullDocumentBackImageBase64 != null &&
//       _fullDocumentBackImageBase64 != "") {
//     fullDocumentBackImage = Column(
//       children: <Widget>[
//         Text("Document Back Image:"),
//         Image.memory(
//           Base64Decoder().convert(_fullDocumentBackImageBase64),
//           height: 180,
//           width: 350,
//         )
//       ],
//     );
//   }

//   Widget faceImage = Container();
//   if (_faceImageBase64 != null && _faceImageBase64 != "") {
//     faceImage = Column(
//       children: <Widget>[
//         Text("Face Image:"),
//         Image.memory(
//           Base64Decoder().convert(_faceImageBase64),
//           height: 150,
//           width: 100,
//         )
//       ],
//     );
//   }

//   return MaterialApp(
//       home: Scaffold(
//     appBar: AppBar(
//       title: const Text("BlinkID Sample"),
//     ),
//     body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Padding(
//                 child: RaisedButton(
//                   child: Text("Scan"),
//                   onPressed: () => scan(),
//                 ),
//                 padding: EdgeInsets.only(bottom: 16.0)),
//             Text(_resultString),
//             fullDocumentFrontImage,
//             fullDocumentBackImage,
//             faceImage,
//           ],
//         )),
//   ));
// }
// }
