import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bugly_config.dart';
import 'bugly_plugin_platform_interface.dart';

/// An implementation of [BuglyPluginPlatform] that uses method channels.
class MethodChannelBuglyPlugin extends BuglyPluginPlatform {
  final String methodGetVersion = 'getPlatformVersion';
  final String methodInitBugly = 'initBugly';
  final String methodReportException = 'reportException';
  final String methodTestNativeCrash = "testNativeCrash";
  final String methodSetDeviceId = "setDeviceId";

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bugly_plugin');

  /// return now platform version
  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(methodGetVersion);
    return version;
  }

  /// init tencent bugly
  @override
  void initBugly(BuglyConfig config) {
    methodChannel.invokeMethod(methodInitBugly, config.toMap());
  }

  /// custom report exception
  @override
  void reportException(String errorMsg, String stackInfo) {
    methodChannel.invokeMethod(
        methodReportException, {"errorMsg": errorMsg, "stackInfo": stackInfo});
  }

  @override
  void testNativeCrash() {
    methodChannel.invokeMethod(methodTestNativeCrash);
  }

  @override
  void setDeviceId(String userId) {
    methodChannel.invokeMethod(methodSetDeviceId, {"userId": userId});
  }
}
