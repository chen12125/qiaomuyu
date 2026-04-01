package com.woodenfish

import android.app.Dialog
import android.os.Bundle
import android.widget.SeekBar
import android.widget.Switch
import androidx.appcompat.app.AppCompatActivity

class SettingsActivity : AppCompatActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_settings)
        
        // 初始化设置项
        val soundVolumeSeekBar = findViewById<SeekBar>(R.id.soundVolume)
        val vibrationSwitch = findViewById<Switch>(R.id.vibrationSwitch)
        
        // 设置音量SeekBar监听
        soundVolumeSeekBar.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                // TODO: 保存音量设置
            }
            
            override fun onStartTrackingTouch(seekBar: SeekBar?) {}
            
            override fun onStopTrackingTouch(seekBar: SeekBar?) {}
        })
        
        // 设置振动开关监听
        vibrationSwitch.setOnCheckedChangeListener { _, isChecked ->
            // TODO: 保存振动设置
        }
        
        // 开发者的话点击事件
        val developerWordsLayout = findViewById<android.widget.LinearLayout>(R.id.developerWordsLayout)
        developerWordsLayout.setOnClickListener {
            showDeveloperWordsDialog()
        }
        
        // 关于应用点击事件
        val aboutLayout = findViewById<android.widget.LinearLayout>(R.id.aboutLayout)
        aboutLayout.setOnClickListener {
            // TODO: 打开关于应用页面
        }
    }
    
    private fun showDeveloperWordsDialog() {
        val dialog = Dialog(this)
        dialog.setContentView(R.layout.dialog_developer_words)
        dialog.setTitle(getString(R.string.developer_words_title))
        
        // 设置确定按钮点击事件
        val okButton = dialog.findViewById<android.widget.Button>(R.id.okButton)
        okButton.setOnClickListener {
            dialog.dismiss()
        }
        
        dialog.show()
    }
}