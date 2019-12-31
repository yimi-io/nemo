import 'dart:async';

import 'package:flutter/services.dart';

class Nemo {
  static const MethodChannel _channel =
      const MethodChannel('nemo');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
