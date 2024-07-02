import Flutter
import UIKit
import Bugly
public class BuglyPlugin: NSObject, FlutterPlugin {
    let MethodGetVersion: String = "getPlatformVersion"
    let MethodInitBugly: String = "initBugly"
    let MethodReportException: String = "reportException"
    let MethodTestNativeCrash: String = "testNativeCrash"
    let MethodSetUserId: String = "setUserId"
    
    var debugMode = false
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "bugly_plugin", binaryMessenger: registrar.messenger())
        let instance = BuglyPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case MethodGetVersion:
            result("iOS " + UIDevice.current.systemVersion)
        case MethodInitBugly:
            let configMap = call.arguments as! Dictionary<String,Any>
            let buglyConfig = BuglyConfig.init()
            debugMode = configMap["isDebug"] as! Bool
            buglyConfig.debugMode = configMap["isDebug"] as! Bool
            buglyConfig.channel = configMap["channel"] as! String
            Bugly.start(withAppId: configMap["iosAppId"] as? String,config: buglyConfig)
            result("")
        case MethodReportException:
            let  errorMap = call.arguments as! Dictionary<String,Any>
            
            //5 JS  6Lua
            Bugly.reportException(withCategory: 5, name: "FlutterException", reason: errorMap["errorMsg"] as!  String, callStack: (errorMap["stackInfo"] as! String).components(separatedBy: "\n"), extraInfo: [:], terminateApp: false)
            result("")
        case MethodTestNativeCrash:
            if(debugMode){
                fatalError("Test Bugly Crash Collect")
                
            }else{
                print("not support test bugly crash")
            }
            result("")
        case MethodSetUserId:
            let configMap = call.arguments as! Dictionary<String,Any>
            Bugly.setUserIdentifier(configMap["userId"] as! String)
            result("")
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
