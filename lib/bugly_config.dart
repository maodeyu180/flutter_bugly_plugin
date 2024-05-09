///@author ： 于德海
///time ： 2024/5/8 16:06
///desc ：
///

class BuglyConfig{
  final String androidAppId;
  final String iosAppId ;
  String _appChannel = "";
  bool _isDebug = false;
  BuglyConfig( {required this.androidAppId, required this.iosAppId, String? channel, bool? debugMode}){
    _isDebug = debugMode ?? false;
    _appChannel = channel ?? "";
  }


  Map<String,dynamic> toMap(){
    return {
      "androidAppId":androidAppId,
      "iosAppId":iosAppId,
      "channel": _appChannel,
      "isDebug" : _isDebug
    };
  }

}