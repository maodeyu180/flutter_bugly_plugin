package com.flutter.bugly_plugin

import com.tencent.bugly.proguard.r
import org.intellij.lang.annotations.RegExp

/***
 * @author ： 于德海
 * time ： 2024/5/8 18:23
 * desc ：
 */
class FlutterException(message: String, stackInfo: String) : Throwable(message) {
    init {
        val stacks = arrayListOf<StackTraceElement>()
        val strs = stackInfo.split("\n")
        for (s in strs){
            val element = StackTraceElement("Flutter",s,"",0)
            stacks.add(element)
        }
        stackTrace = stacks.toTypedArray()
    }
}