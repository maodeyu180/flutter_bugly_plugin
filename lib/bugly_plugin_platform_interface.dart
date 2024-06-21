import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bugly_config.dart';
import 'bugly_plugin_method_channel.dart';

abstract class BuglyPluginPlatform extends PlatformInterface {
  /// Constructs a BuglyPluginPlatform.
  BuglyPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static BuglyPluginPlatform _instance = MethodChannelBuglyPlugin();

  /// The default instance of [BuglyPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelBuglyPlugin].
  static BuglyPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BuglyPluginPlatform] when
  /// they register themselves.
  static set instance(BuglyPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void initBugly(BuglyConfig config) {
    throw UnimplementedError('initBugly() has not been implemented.');
  }

  void reportException(String errorMsg, String stackInfo) {
    throw UnimplementedError('reportException() has not been implemented.');
  }

  void testNativeCrash() {
    throw UnimplementedError('testNativeCrash() has not been implemented.');
  }

  void setUserId(String userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }
}
