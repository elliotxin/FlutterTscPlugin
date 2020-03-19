import 'dart:async';
import 'package:flutter/services.dart';

class FlutterTsc {
  static const MethodChannel _channel = const MethodChannel('flutter_tsc');
  static Future<String> print({
    String ipAddress,
    String label,
    String number,
    String demand,
    String uom,
    String received,
    String origin,
    String contact,
    String expiryDate,
    String currentDate,
    String location,
    String staffId,
    String productCode,
  }) async {
    final String result = await _channel.invokeMethod('print', {
      'ipAddress': ipAddress,
      'label': label,
      'number': number,
      'demand': demand,
      'uom': uom,
      'received': received,
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
}
