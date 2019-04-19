package net.julianchu.applinktest

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.TextView

class FirstActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_first)

        val textView = findViewById<TextView>(android.R.id.text1)
        val msg = "FirstActivity got intent: ${intent.dataString}"
        textView.text = msg
        Log.d(TAG, "(not) IntentFilter: $msg")
    }
}
