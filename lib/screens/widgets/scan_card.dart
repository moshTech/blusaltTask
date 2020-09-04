import 'package:firebase_auth_with_get_state/models/scan.dart';
import 'package:flutter/material.dart';

class ScanCard extends StatelessWidget {
  final String uid;
  final ScanModel scan;

  const ScanCard({Key key, this.uid, this.scan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 5, right: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                scan.fullName,
              ),
              SizedBox(
                height: 5,
              ),
              Text('Sex',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                scan.sex,
              ),
              SizedBox(
                height: 5,
              ),
              Text('Address',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                scan.address,
              ),
              SizedBox(
                height: 5,
              ),
              Text('Date of birth',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                'dob: ${scan.dob}',
              ),
              SizedBox(
                height: 5,
              ),
              Text('Document number',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                scan.docNumb,
              ),
              SizedBox(
                height: 5,
              ),
              Text('Permanent',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                scan.expPerm,
              ),
              Text('Date scanned',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                scan.dateCreated.toDate().toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
