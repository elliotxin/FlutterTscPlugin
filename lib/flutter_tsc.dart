import 'dart:async';
import 'package:flutter/services.dart';

class Tsc {
  static const MethodChannel _channel = const MethodChannel('tsc');

  static Future<String> print({String ipAddress, String label}) async {
    final String result = await _channel
        .invokeMethod('print', {'ipAddress': ipAddress, 'label': label});
    return result;
  }
}
