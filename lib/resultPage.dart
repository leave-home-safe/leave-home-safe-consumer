import 'dart:async';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:leave_home_safe_mobile/location.dart';
import 'package:leave_home_safe_mobile/result.dart';

class ResultPage extends StatefulWidget {
  final LeaveHomeSafe leaveHomeSafe;

  const ResultPage({Key? key, required this.leaveHomeSafe}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late final String signedJWT;
  late final DateTime createdAt;
  late final DateTime expiresAt;
  late Duration timeLeft;

  @override
  void initState() {
    final leaveHomeSafeResult = LeaveHomeSafeResult(
      vaccinated: false,
      visitedAt: DateTime.now(),
    );

    final jwt = JWT(
      leaveHomeSafeResult.toJson(),
    );
    signedJWT = jwt.sign(
      SecretKey(widget.leaveHomeSafe.key),
      expiresIn: Duration(minutes: 4),
    );
    createdAt = DateTime.now();
    expiresAt = createdAt.add(Duration(minutes: 4));

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          timeLeft = expiresAt.difference(DateTime.now());
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BarcodeWidget(
              data: signedJWT,
              barcode: Barcode.qrCode(
                errorCorrectLevel: BarcodeQRCorrectionLevel.quartile,
              ),
              color: Colors.black,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Text(
              widget.leaveHomeSafe.location,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
            ),
            Text(
              "Expire in ${timeLeft.inSeconds} Seconds",
            ),
          ],
        ),
      ),
    );
  }
}
