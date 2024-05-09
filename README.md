# flutter_bugly_plugin
[![pub package](https://img.shields.io/pub/v/tencent_bugly_plugin?style=flat)](https://pub.dev/packages/tencent_bugly_plugin)[![stars](https://img.shields.io/github/stars/yudehai0204/flutter_bugly_plugin?style=social)](https://github.com/yudehai0204/flutter_bugly_plugin)



Flutter Bugly 插件，只集成了崩溃统计

## Bugly版本

Android Bugly Version : 4.1.9.3

IOS Bugly Version : 2.6.1

## 使用
```yaml
dependencies:
  tencent_bugly_plugin: ^latest
```


### 混淆
Android需要配置混淆
```java
-dontwarn com.tencent.bugly.**
-keep public class com.tencent.bugly.**{*;}
```

### 初始化

任意区域调用. androidID 与 ios 为必传，其他为可选项。

```dart
  BuglyPlugin.initBugly(
      BuglyConfig(
          androidAppId: "your android AppId",
          iosAppId: "your ios AppId",
          channel: "your channel",
          debugMode: true), flutterError: (flutterError) {

  });
```

### 上报自己try catch的异常

```dart
   BuglyPlugin.reportException(String errorInfo,String errorStack)
```    

dart触发的错误在bugly的错误界面
