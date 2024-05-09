import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bugly_config.dart';
import 'bugly_plugin_platform_interface.dart';

/// An implementation of [BuglyPluginPlatform] that uses method channels.
class MethodChannelBuglyPlugin extends BuglyPluginPlatform {
  final String MethodGetVersion = 'getPlatformVersion';
  final String MethodInitBugly = 'initBugly';
  final String MethodReportException = 'reportException';
  final String MethodTestNativeCrash = "testNativeCrash";
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bugly_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(MethodGetVersion);
    return version;
  }

  @override
  void initBugly(BuglyConfig config) {
    methodChannel.invokeMethod(MethodInitBugly,config.toMap());
  }
  
  @override
  void reportException(String errorMsg, String stackInfo) {
    methodChannel.invokeMethod(MethodReportException,{"errorMsg": errorMsg, "stackInfo": stackInfo});
  }

  @override
  void testNativeCrash(){
    methodChannel.invokeMethod(MethodTestNativeCrash);
  }
}
