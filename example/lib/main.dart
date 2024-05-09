import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tencent_bugly_plugin/bugly_config.dart';
import 'package:tencent_bugly_plugin/bugly_plugin.dart';

void main() {
  BuglyPlugin.initBugly(
      BuglyConfig(
          androidAppId: "b9668c775a",
          iosAppId: "15910284fd",
          channel: "Demo",
          debugMode: true), flutterError: (flutterError) {
    print("receive error: $flutterError");
    print("errorinfo = ${flutterError.exception};");
    print("stack = ${flutterError.stack}");
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await BuglyPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            ElevatedButton(
                onPressed: () {
                  throw Exception('OnlyTestFlutterCodeCrash');
                },
                child: Text("Test DartCrash")),
            ElevatedButton(
                onPressed: () {
                  BuglyPlugin.testNativeCrash();
                },
                child: Text("Test NativeCrash"))
          ],
        )),
      ),
    );
  }
}
