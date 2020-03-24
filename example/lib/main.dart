import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tsc/flutter_tsc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _printMessage = 'unknow';
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _numberOfLabel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _numberOfLabel,
                decoration: InputDecoration(labelText: 'Number of Label'),
              ),
              TextField(
                controller: _xController,
                decoration: InputDecoration(labelText: 'label'),
              ),
              Text(_printMessage),
              SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: 300,
                height: 50,
                child: Text('Print'),
                color: Colors.black,
                textColor: Colors.white,
                elevation: 15,
                onPressed: print,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> print() async {
    String printMessage;
    String number = _numberOfLabel.text;
    String product = _xController.text;
    try {
      printMessage = await FlutterTsc.print(
        ipAddress: '192.168.0.153',
        product: product,
        lot: '200319004700001',
        number: number,
        demand: '50',
        uom: 'KG',
        received: '20',
        origin: 'P00008',
        contact: 'vendor',
        expiryDate: '03/22/2020',
        currentDate: '03/18/2020',
        location: 'WH/Stock',
        staffId: 'D01',
        productCode: 'FV-VOS-EDFLMG',
      );
    } on PlatformException {
      printMessage = 'Failed to communcate with this printer. ';
    }

    setState(() {
      _printMessage = printMessage;
    });
  }
}
