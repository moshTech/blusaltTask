import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_with_get_state/models/scan.dart';
import 'package:firebase_auth_with_get_state/models/user.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  Future createUser(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return UserModel.fromJson(
        userData.data(),
      );
    } catch (e) {
      return e.message;
    }
  }

  Future updateUser(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.id).update(user.toJson());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<void> addScan(
      {fullName,
      address,
      docNumber,
      sex,
      dob,
      // dateIssue,
      // age,
      expPerm,
      profession,
      uid}) async {
    try {
      await _usersCollectionReference.doc(uid).collection("scans").add({
        'dateCreated': Timestamp.now(),
        'fullName': fullName,
        'address': address,
        'docNumb': docNumber,
        'sex': sex,
        // 'dateIssue': dateIssue,
        // 'age': age,
        'dob': dob,
        'expPerm': expPerm,
        'profession': profession,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<ScanModel>> scanStream(String uid) {
    return _usersCollectionReference
        .doc(uid)
        .collection("scans")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ScanModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(ScanModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }
}
