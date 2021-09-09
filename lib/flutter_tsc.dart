import 'dart:async';
import 'package:flutter/services.dart';

class FlutterTsc {
  static const MethodChannel _channel = const MethodChannel('flutter_tsc');
  static Future<String> inbound({
    String ipAddress,
    String lot,
    String product,
    String number,
    String purchaseUom,
    String uom,
    String uomQty,
    String printedName,
    String done,
    String origin,
    String contact,
    String expiryDate,
    String currentDate,
    String location,
    String staffId,
    String productCode,
  }) async {
    final String result = await _channel.invokeMethod('inbound', {
      'ipAddress': ipAddress,
      'lot': lot,
      'product': product,
      'number': number,
      'purchaseUom': purchaseUom,
      'uom': uom,
      'uomQty': uomQty,
      'printedName': printedName,
      'done': done,
      'origin': origin,
      'contact': contact,
      'expiryDate': expiryDate,
      'currentDate': currentDate,
      'location': location,
      'staffId': staffId,
      'productCode': productCode,
    });
    return result;
  }

  static Future<String> outbound({
    String ipAddress,
    String label,
    String product,
    String qtyDone,
    String expireDate,
    String packDate,
    String invoice,
    String po,
    String customer,
    String outlet,
    String number,
    String ref,
    String internalNote,
  }) async {
    final String result = await _channel.invokeMethod('outbound', {
      'ipAddress': ipAddress,
      'label': label,
      'product': product,
      'qtyDone': qtyDone,
      'expireDate': expireDate,
      'packDate': packDate,
      'invoice': invoice,
      'po': po,
      'customer': customer,
      'outlet': outlet,
      'number': number,
      'ref': ref,
      'internalNote': internalNote,
    });
    return result;
  }
}
