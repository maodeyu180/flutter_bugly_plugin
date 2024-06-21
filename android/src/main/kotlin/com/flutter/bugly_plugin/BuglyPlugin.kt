package com.flutter.bugly_plugin

import android.content.Context
import android.util.Log
import com.tencent.bugly.crashreport.CrashReport
import com.tencent.bugly.crashreport.CrashReport.UserStrategy
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** BuglyPlugin */
class BuglyPlugin : FlutterPlugin, MethodCallHandler {

    val MethodGetVersion: String = "getPlatformVersion"
    val MethodInitBugly: String = "initBugly"
    val MethodReportException: String = "reportException"
    val MethodTestNativeCrash: String = "testNativeCrash"
    val MethodSetDeviceId: String = "setDeviceId"

    lateinit var context: Context

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bugly_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext

    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            MethodGetVersion -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            MethodInitBugly -> {
                val strategy = UserStrategy(context)
                val configMap = call.arguments as Map<String, Any>
                strategy.setAppChannel(configMap["channel"] as String)
                CrashReport.initCrashReport(context,configMap["androidAppId"] as String, configMap["isDebug"] as Boolean,strategy)
                result.success("")
            }
            MethodReportException->{
                val errorMap = call.arguments as Map<String, String>
                CrashReport.postCatchedException(FlutterException(errorMap["errorMsg"]as String,errorMap["stackInfo"] as String))
//                CrashReport.postException(4, "FlutterException", errorMap["errorMsg"]as String,errorMap["stackInfo"],null)
            }
            MethodTestNativeCrash->{
                Thread(kotlinx.coroutines.Runnable {
                    CrashReport.testJavaCrash()
                }).start()

            }
            MethodSetDeviceId->{
                val configMap = call.arguments as Map<String, Any>
                CrashReport.setDeviceId(context, configMap["userId"] as String)
            }
            else -> {
                result.notImplemented()
            }
        }

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
