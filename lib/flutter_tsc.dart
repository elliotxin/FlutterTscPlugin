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
    String number,
    String product,
    String qtyDone,
    String customer,
    String pickId,
    String packId,
    String invoice,
    String outlet,
    String date,
    String custId,
    String route,
  }) async {
    final String result = await _channel.invokeMethod('outbound', {
      'ipAddress': ipAddress,
      'label': label,
      'number': number,
      'product': product,
      'qtyDone': qtyDone,
      'customer': customer,
      'pickId': pickId,
      'packId': packId,
      'invoice': invoice,
      'outlet': outlet,
      'date': date,
      'custId': custId,
      'route': route,
    });
    return result;
  }
}
