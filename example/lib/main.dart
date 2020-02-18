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
                  onPressed: print),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> print() async {
    String printMessage;
    try {
      printMessage =
          await FlutterTsc.print(ipAddress: '192.168.5.101', label: 'apple');
    } on PlatformException {
      printMessage = 'Failed to communcate with this printer. ';
    }

    setState(() {
      _printMessage = printMessage;
    });
  }
}
