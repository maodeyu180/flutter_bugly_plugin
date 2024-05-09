import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tecncent_bugly_plugin/bugly_config.dart';
import 'package:tecncent_bugly_plugin/bugly_plugin.dart';
import 'package:tecncent_bugly_plugin/bugly_plugin_method_channel.dart';
import 'package:tecncent_bugly_plugin/bugly_plugin_platform_interface.dart';

class MockBuglyPluginPlatform
    with MockPlatformInterfaceMixin
    implements BuglyPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  String get MethodGetVersion => throw UnimplementedError();

  @override
  String get MethodInitBugly => throw UnimplementedError();

  @override
  String get MethodReportException => throw UnimplementedError();

  @override
  void initBugly(BuglyConfig config) {
  }



  @override
  void testNativeCrash() {
  }

  @override
  void reportException(String errorMsg, String stackInfo) {
  }
}

void main() {
  final BuglyPluginPlatform initialPlatform = BuglyPluginPlatform.instance;

  test('$MethodChannelBuglyPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBuglyPlugin>());
  });

  test('getPlatformVersion', () async {
    BuglyPlugin buglyPlugin = BuglyPlugin();
    MockBuglyPluginPlatform fakePlatform = MockBuglyPluginPlatform();
    BuglyPluginPlatform.instance = fakePlatform;

    expect(await BuglyPlugin.getPlatformVersion(), '42');
  });
}
