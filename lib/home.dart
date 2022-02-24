import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:leave_home_safe_mobile/location.dart';
import 'package:leave_home_safe_mobile/resultPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Button
                ElevatedButton(
                  child: Text('Scan QR Code'),
                  onPressed: () async {
                    var result =
                        await BarcodeScanner.scan(options: ScanOptions());

                    final parsedResult =
                        leaveHomeSafeFromJson(result.rawContent);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => ResultPage(leaveHomeSafe: parsedResult),
                      ),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
