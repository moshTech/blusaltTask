import 'package:cloud_firestore/cloud_firestore.dart';

class ScanModel {
  String fullName;
  String scanId;
  Timestamp dateCreated;
  String address;
  String docNumb;
  String sex;
  String dob;
  String expPerm;
  String profession;

  ScanModel({
    this.fullName,
    this.scanId,
    this.dateCreated,
    this.address,
    // this.docNumb,
    this.sex,
    this.dob,
    this.expPerm,
    this.profession,
  });

  ScanModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    scanId = documentSnapshot.id;
    fullName = documentSnapshot.get('fullName');
    dateCreated = documentSnapshot.get('dateCreated');
    address = documentSnapshot.get('address');
    docNumb = documentSnapshot.get('docNumb');
    sex = documentSnapshot.get('sex');
    dob = documentSnapshot.get('dob');
    expPerm = documentSnapshot.get('expPerm');
    profession = documentSnapshot.get('profession');
  }
}
