import 'dart:async';

import 'package:flutter/material.dart';

import 'bugly_config.dart';
import 'bugly_plugin_platform_interface.dart';

class BuglyPlugin {
  static Future<String?> getPlatformVersion() {
    return BuglyPluginPlatform.instance.getPlatformVersion();
  }

  ///Initialize Bugly
  static void initBugly(BuglyConfig config,
      {Function(FlutterErrorDetails)? flutterError}) {
    WidgetsFlutterBinding.ensureInitialized();
    BuglyPluginPlatform.instance.initBugly(config);
    FlutterError.onError = (FlutterErrorDetails details) {
      BuglyPluginPlatform.instance.reportException(
          details.exception.toString(), details.stack.toString());
      FlutterError.dumpErrorToConsole(details);
      if (flutterError != null) {
        flutterError(details);
      }
    };
  }

  /// report try catch exception
  static void reportException(String errorTitle, String stackInfo) {
    BuglyPluginPlatform.instance.reportException(errorTitle, stackInfo);
  }

  /// Test Crash collection
  static void testNativeCrash() {
    BuglyPluginPlatform.instance.testNativeCrash();
  }

  // set userId
  static void setDeviceId(String userId) {
    BuglyPluginPlatform.instance.setDeviceId(userId);
  }
}
