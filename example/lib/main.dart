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
  final TextEditingController _product = TextEditingController();
  final TextEditingController _ipLabel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TSC Printer Test Kit'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _ipLabel,
                decoration: InputDecoration(labelText: 'IP Address'),
              ),
              TextField(
                controller: _product,
                decoration: InputDecoration(labelText: 'Product'),
              ),
              Text(_printMessage),
              SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: 300,
                height: 50,
                child: Text('inbound'),
                color: Colors.black,
                textColor: Colors.white,
                elevation: 15,
                onPressed: inbound,
              ),
              SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: 300,
                height: 50,
                child: Text('outbound(Exp)'),
                color: Colors.black,
                textColor: Colors.white,
                elevation: 15,
                onPressed: outboundExp,
              ),
              SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: 300,
                height: 50,
                child: Text('outbound'),
                color: Colors.black,
                textColor: Colors.white,
                elevation: 15,
                onPressed: outbound,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> inbound() async {
    String printMessage;
    String idAddress = _ipLabel.text;
    String product = _product.text;
    try {
      printMessage = await FlutterTsc.inbound(
        ipAddress: idAddress,
        product: product,
        lot: '200319004700001',
        number: '1',
        uomQty: '50',
        uom: 'KG',
        done: '20',
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

  Future<void> outbound() async {
    String printMessage;
    String idAddress = _ipLabel.text;
    String product = _product.text;
    try {
      printMessage = await FlutterTsc.outbound(
        ipAddress: idAddress,
        label: '200319004700001',
        product: product,
        qtyDone: '3.4 KG',
        expireDate: '',
        packDate: '03 JUN 2021',
        invoice: 'INV: 21034539',
        po: 'PO: 00000066402',
        customer: 'ANDAZ',
        outlet: '665F',
        number: '1',
        ref: 'A20',
        internalNote: 'R1',
      );
    } on PlatformException {
      printMessage = 'Failed to communcate with this printer. ';
    }

    setState(() {
      _printMessage = printMessage;
    });
  }

  Future<void> outboundExp() async {
    String printMessage;
    String idAddress = _ipLabel.text;
    String product = _product.text;
    try {
      printMessage = await FlutterTsc.outbound(
        ipAddress: idAddress,
        label: '200319004700001',
        product: product,
        qtyDone: '3.4 KG',
        expireDate: '06 JUN 2021',
        packDate: '03 JUN 2021',
        invoice: 'INV: 21034539',
        po: 'PO: 00000066402',
        customer: 'ANDAZ',
        outlet: '665F',
        number: '1',
        ref: 'A20',
        internalNote: 'R1',
      );
    } on PlatformException {
      printMessage = 'Failed to communcate with this printer. ';
    }

    setState(() {
      _printMessage = printMessage;
    });
  }
}
