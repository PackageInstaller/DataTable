--本地保存数据索引  有新值需要在SettingMgr的InitLocalCfg后赋初始值保存
--获取游戏音频大小
s_isSetting = "s_isSetting" --是否已设置过

s_audio_scale = {
	music = "music",       --音乐
	sound = "sound",       --音效
	dubbing = "dubbing",     --配音
}

s_audio_value = {music = 100, sound = 100, dubbing = 100} --默认大小

--质量key  数值：123=低中高
s_quality_key = "s_quality_key_imgquality"        --画质   
s_quality_value = 2 --默认等级  

--屏幕适应 0-100 
s_screen_scale_key = "s_screen_scale_key"
s_screen_scale_default = 100  --Iphonex 默认为0

--帧数开关 1:60帧  2:30帧
s_toggle_zs_key = "s_toggle_zs_key"
s_toggle_zs_default = 2

--描边开关 1：开  2：关
s_toggle_mb_key = "s_toggle_mb_key"
s_toggle_mb_default = 2

--锯齿 1：开  2：关
s_toggle_jc_key = "s_toggle_jc_key"
s_toggle_jc_default = 2 

s_mobie_lv_key = "s_mobie_lv_key"       
s_mobie_score_key = "s_mobie_score_key"        --画质  
s_mobie_middle = 115  --中机型最低分
s_mobie_height = 150 --高机型最低分

s_music_cache_key = "14016"

--战斗动画开关 1:一日一次 2:开 3:关
s_fight_action_key = "s_fight_action_key"
s_fight_action_default = 2

--战斗技能简要描述 1：开  2：关
s_fight_simple_key = "s_fight_simple_key"
s_fight_simple_default = 2

s_language_key = "s_language_key"
s_language_key_default = 0  --日：0  中：1 

--直播 1：开  2：关
s_other_live_key = "s_other_live_key"
s_other_live_default = 2

--芯片自动上锁 1：开  2：关
s_other_equipLock_key = "s_other_equipLock_key"
s_other_equipLock_default = 2

s_wait_scale = {}
s_wait_value = {}
--时间格式 0:12小时 1:24小时
s_wait_scale.timeFormat = "timeFormat"
s_wait_value.timeFormat = 0
--待机界面风格 0：默认 1：纯净 2：自定义
s_wait_scale.style = "style"
s_wait_value.style = 0
--功能提示 0：开启 1：关闭
s_wait_scale.tips = "tips"
s_wait_value.tips = 0
--时间显示 0：开启 1：关闭
s_wait_scale.time = "time"
s_wait_value.time = 0
--电量显示 0：开启 1：关闭
s_wait_scale.electric = "electric"
s_wait_value.electric = 0
--日期显示 0：开启 1：关闭
s_wait_scale.date = "date"
s_wait_value.date = 0
--轮换显示 0：开启 1：关闭
s_wait_scale.rotate = "rotate"
s_wait_value.rotate = 0
--待机时间设置 g_HoldOnTime 0：3分钟（对应第一个下标） 1：5分钟（对应第二个下标） 2：10分钟（对应第三个下标） 3：从不（对应第四个下标）
s_wait_scale.waitTime = "waitTime"
s_wait_value.waitTime = 0
