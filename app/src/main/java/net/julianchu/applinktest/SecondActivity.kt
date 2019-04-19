package net.julianchu.applinktest

import android.os.Bundle
import android.util.Log
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class SecondActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)

        val textView = findViewById<TextView>(android.R.id.text1)
        val msg = "SecondActivity got intent: ${intent.dataString}"
        textView.text = msg
        Log.d(TAG, "(not) IntentFilter: $msg")
    }
}
