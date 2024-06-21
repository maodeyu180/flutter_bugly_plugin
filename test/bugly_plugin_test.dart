import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tencent_bugly_plugin/bugly_config.dart';
import 'package:tencent_bugly_plugin/bugly_plugin.dart';
import 'package:tencent_bugly_plugin/bugly_plugin_method_channel.dart';
import 'package:tencent_bugly_plugin/bugly_plugin_platform_interface.dart';

class MockBuglyPluginPlatform
    with MockPlatformInterfaceMixin
    implements BuglyPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  String get methodGetVersion => throw UnimplementedError();

  String get methodInitBugly => throw UnimplementedError();

  String get methodReportException => throw UnimplementedError();

  @override
  void initBugly(BuglyConfig config) {}

  @override
  void testNativeCrash() {}

  @override
  void reportException(String errorMsg, String stackInfo) {}

  @override
  void setDeviceId(String userId) {}
}

void main() {
  final BuglyPluginPlatform initialPlatform = BuglyPluginPlatform.instance;

  test('$MethodChannelBuglyPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBuglyPlugin>());
  });

  test('getPlatformVersion', () async {
    MockBuglyPluginPlatform fakePlatform = MockBuglyPluginPlatform();
    BuglyPluginPlatform.instance = fakePlatform;

    expect(await BuglyPlugin.getPlatformVersion(), '42');
  });
}
