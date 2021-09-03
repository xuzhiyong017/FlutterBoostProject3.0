package com.sky.androidapp

import android.app.Application
import android.content.Intent
import android.util.Log
import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.FlutterBoostDelegate
import com.idlefish.flutterboost.FlutterBoostRouteOptions
import com.idlefish.flutterboost.containers.FlutterBoostActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs
import io.flutter.embedding.engine.FlutterEngine


/**
 * @author: xuzhiyong
 * @date: 2021/9/3  下午3:05
 * @Email: 18971269648@163.com
 * @description:
 */
class App : Application() {

    override fun onCreate() {
        super.onCreate()
        FlutterBoost.instance().setup(this, object : FlutterBoostDelegate {
            override fun pushNativeRoute(options: FlutterBoostRouteOptions) {
                val intent = Intent(FlutterBoost.instance().currentActivity(),
                    SecondActivity::class.java
                )
                Log.d("options","options ${options.pageName()} ${options.arguments()}")
                FlutterBoost.instance().currentActivity().startActivityForResult(intent, options.requestCode())
            }

            override fun pushFlutterRoute(options: FlutterBoostRouteOptions) {
                val intent = FlutterBoostActivity.CachedEngineIntentBuilder(
                    FlutterBoostActivity::class.java
                )
                    .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                    .destroyEngineWithActivity(false)
                    .uniqueId(options.uniqueId())
                    .url(options.pageName())
                    .urlParams(options.arguments())
                    .build(FlutterBoost.instance().currentActivity())
                FlutterBoost.instance().currentActivity().startActivity(intent)
            }
        }) { println("start flutter engine") }
    }
}