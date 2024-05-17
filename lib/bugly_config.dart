///@author ： 于德海
///time ： 2024/5/8 16:06
///desc ： Class `BuglyConfig` is used to configure Bugly,
class BuglyConfig{
  /// `androidAppId` is the Android Bugly AppId
  final String androidAppId;
  /// `iosAppId` is the IOS Bugly AppId
  final String iosAppId ;

  ///  `_appChannel` is the distribution channel of the app.
  String _appChannel = "";
  /// `_isDebug` is a boolean value that indicates whether the bugly is in debug mode.
  bool _isDebug = false;

  BuglyConfig( {required this.androidAppId, required this.iosAppId, String? channel, bool? debugMode}){
    _isDebug = debugMode ?? false;
    _appChannel = channel ?? "";
  }


  /// params to Map trans by channel
  Map<String,dynamic> toMap(){
    return {
      "androidAppId":androidAppId,
      "iosAppId":iosAppId,
      "channel": _appChannel,
      "isDebug" : _isDebug
    };
  }

}