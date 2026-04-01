package com.woodenfish

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    
    private var meritCount = 0
    private lateinit var meritTextView: TextView
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        // 初始化UI组件
        meritTextView = findViewById(R.id.meritCount)
        val tapButton = findViewById<Button>(R.id.tapButton)
        val settingsButton = findViewById<Button>(R.id.settingsButton)
        
        // 设置敲击按钮点击事件
        tapButton.setOnClickListener {
            tapWoodenFish()
        }
        
        // 设置按钮点击事件
        settingsButton.setOnClickListener {
            openSettings()
        }
        
        // 显示初始功德数
        updateMeritCount()
    }
    
    private fun tapWoodenFish() {
        meritCount++
        updateMeritCount()
        
        // TODO: 播放敲击音效
        // TODO: 添加振动反馈
        
        // 简单的敲击动画
        val woodenFishImage = findViewById<android.widget.ImageView>(R.id.woodenFishImage)
        woodenFishImage.animate()
            .scaleX(0.9f)
            .scaleY(0.9f)
            .setDuration(50)
            .withEndAction {
                woodenFishImage.animate()
                    .scaleX(1.0f)
                    .scaleY(1.0f)
                    .setDuration(50)
                    .start()
            }
            .start()
    }
    
    private fun updateMeritCount() {
        meritTextView.text = getString(R.string.merit_count, meritCount)
    }
    
    private fun openSettings() {
        val intent = Intent(this, SettingsActivity::class.java)
        startActivity(intent)
    }
}