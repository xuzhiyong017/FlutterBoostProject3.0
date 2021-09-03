package com.sky.androidapp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.FlutterBoostUtils
import com.idlefish.flutterboost.FlutterBoostRouteOptions




class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

    }

    fun jumpToPage(view: View) {
        val options = FlutterBoostRouteOptions.Builder()
            .pageName("homePage")
            .arguments(HashMap())
            .requestCode(1111)
            .build()
        FlutterBoost.instance().open(options)
    }
}