-- 设置
require "SettingKey"
-- local this = MgrRegister("SettingMgr")
SettingMgr = {}
local this = SettingMgr

function this:Init()
    self.datas = {}
    self:InitLocalCfg()
    SettingMgr:SaveValue(s_fight_simple_key, SettingFightSimpleType.Close) --强制关闭简要描述
end

-- 读取本地配置（未设置的默认赋初始值保存一次）
function this:InitLocalCfg()
    isSetting = PlayerPrefs.GetString(s_isSetting)
    if (isSetting == nil or isSetting == "") then
        isSetting = false
        PlayerPrefs.SetString(s_isSetting, "isSet")
    end
    self:SetDatas(s_audio_scale,s_audio_value)
    self:SetDatas(s_wait_scale,s_wait_value)
    self:SetData(s_quality_key, s_quality_value)
    -- local _value = CSAPI.IsIphoneX() and 40 or s_screen_scale_default
    self:SetData(s_screen_scale_key, s_screen_scale_default)
    self:SetData(s_toggle_zs_key, s_toggle_zs_default)
    self:SetData(s_toggle_mb_key, s_toggle_mb_default)
    self:SetData(s_toggle_jc_key, s_toggle_jc_default)
    self:SetData(s_fight_action_key, s_fight_action_default)
    self:SetData(s_fight_simple_key, s_fight_simple_default)
    self:SetData(s_language_key, s_language_key_default) -- 语音
    self:SetData(s_other_live_key, s_other_live_default) -- 语音
    self:SetData(s_other_equipLock_key, s_other_equipLock_default) -- 语音
    -- todo addmore
end

function this:SetDatas(tab1,tab2)
    for i, v in pairs(tab1) do
        self:SetData(v, tab2[v])
    end
end

function this:SetData(_key, _value)
    local value = PlayerPrefs.GetInt(_key)
    if (not isSetting or value == nil) then
        value = _value
        PlayerPrefs.SetInt(_key, value)
    end
    self.datas[_key] = value
end

function this:TrackEventsByFirst()
    local info = FileUtil.LoadByPath("setting_first") or {}
    if info.index == nil then
        info.index = 1
        BuryingPointMgr:TrackEvents("mj_setting", {
            time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(), true),
            eventName = "fight_action",
            key = tostring(self:GetValue("s_fight_action_key"))
        })
        BuryingPointMgr:TrackEvents("mj_setting", {
            time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(), true),
            eventName = "language",
            key = tostring(self:GetValue("s_language_key"))
        })
        BuryingPointMgr:TrackEvents("mj_setting", {
            time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(), true),
            eventName = "bgm",
            cfgId = tostring(BGMMgr:GetViewMusicID())
        })
        FileUtil.SaveToFile("setting_first",info)
    end
end

-- ==============================--
-- desc:刷新音频大小
-- time:2019-09-11 10:23:19
-- @args:
-- @return 
-- ==============================--
function this:SetAudioScale(_key, _value)
    -- self:InitAudio()
    _value = _value / 100
    if (_key == s_audio_scale.music) then
        CSAPI.SetVolume(_value * self:GetSoundVolumeCoeff("bgm"), "bgm")
    elseif (_key == s_audio_scale.sound) then
        CSAPI.SetVolume(_value * self:GetSoundVolumeCoeff(""), "")
    else
        CSAPI.SetVolume(_value, "feature")
    end
end

-- 保存数值  开关数值：12=开关  音乐数值：0-100   品质数值：123=低中高
function this:SaveValue(_key, _value)
    if (_key and _value) then
        self.datas[_key] = _value
        PlayerPrefs.SetInt(_key, _value)
        -- EventMgr.Dispatch(EventType.Main_Setting, {key = _key, value = _value})
    end
end

-- 获取数值
function this:GetValue(_key)
    return self.datas[_key]
end

-- 屏幕适应
function this:SetScreenScale(_num)
    local count = self:GetScreenCount()
    CSAPI.SetLayersRect(count, -count);
    EventMgr.Dispatch(EventType.Screen_Scale, count) -- Todo
end

function this:GetScreenCount()
    local num = _num == nil and self:GetValue(s_screen_scale_key) or _num
    local screenScale = g_Screen_scale_limit or 0;
    local count = screenScale - math.floor(num * screenScale / 100)
    return count
end

--更新目标帧率
function this:UpdateTargetFPS()
    --local rate = self.isHigh and FightClient:IsFightting() and self:GetHighFPS() or 30;
    local rate = self.isHigh and self:GetHighFPS() or 30;
    --LogError(rate);
    CSAPI.SetTargetFrameRate(rate);
end
function this:SetHighFPS(isHigh)
    self.isHigh = isHigh;
    self:UpdateTargetFPS();
end

--获取高帧率
function this:GetHighFPS()
    return 60;
end

-- 预先设置
function this:LoginSet()
    -- -- 音频
    -- CSAPI.SetVolume(self:GetValue(s_audio_scale.music) / 100 * self:GetSoundVolumeCoeff("bgm"), "bgm")
    -- CSAPI.SetVolume(self:GetValue(s_audio_scale.sound) / 100 * self:GetSoundVolumeCoeff(""), "")
    -- CSAPI.SetVolume(self:GetValue(s_audio_scale.dubbing) / 100, "feature")

    -- 画质（+描边开关）
    CSAPI.SetGameLv(self:GetGameImgLv())
    -- 屏幕适应
    self:SetScreenScale()
    -- 帧数
--    local rate = self:GetValue(s_toggle_zs_key) == 1 and self:GetHighFPS() or 30
--    CSAPI.SetTargetFrameRate(rate)
    self:SetHighFPS(self:GetValue(s_toggle_zs_key) == 1);
    --CSAPI.SetTargetFrameRate(60);--刚开始游戏强制高帧，登录视频只有在高帧率下播放才正常
    -- CSAPI.SetVSyncCount(self:GetValue(s_toggle_zs_key))
    -- 描边开关 (设置画质时要默认设置1次描边，反之则不用）
    -- CSAPI.SetShaderOutline(self:GetValue(s_toggle_mb_key)==1)
    -- 首次安装按机型设置画质
    self:SetGameLVFirst()
end

-- 预先设置音量
function this:LoginSoundSet()
    -- 音频
    CSAPI.SetVolume(self:GetValue(s_audio_scale.music) / 100 * self:GetSoundVolumeCoeff("bgm"), "bgm")
    CSAPI.SetVolume(self:GetValue(s_audio_scale.sound) / 100 * self:GetSoundVolumeCoeff(""), "")
    CSAPI.SetVolume(self:GetValue(s_audio_scale.dubbing) / 100, "feature")
end

function this:GetSoundVolumeCoeff(key)
    if (StringUtil:IsEmpty(key)) then
        return 1;
    end
    self.soundVolumeCoeffs = self.soundVolumeCoeffs or {
        bgm = 1
    };
    return self.soundVolumeCoeffs[key];
end

function this:GetGameImgLv()
    local gameLv = self.datas[s_quality_key]
    gameLv = gameLv > 0 and gameLv or 3
    return gameLv
end

-- 首次安装按机型设置画质,非首次不处理
function this:SetGameLVFirst()
    local value = PlayerPrefs.GetInt(s_mobie_lv_key)
    local score = PlayerPrefs.GetInt(s_mobie_score_key)
    if (value == nil or value == 0) then
        -- 生成测试预制体(非手持直接设置为最高级)
        if (not self:SetMaxLv()) then
            CSAPI.CreateGOAsync("UIs/MobieLv/MobieLv", 0, 0, 0, nil, function(go)
                self:CreateGOCB(go)
            end)
            --self:SetScore(150) --测试
        end
    else
        self.mobieLv = value
        self.score = score
    end
end

-- 开始执行
function this:CreateGOCB(go)
    local performanceTest = ComUtil.GetCom(go, "PerformanceTest")
    if (performanceTest) then
        performanceTest:Init(function(score)
            self:SetScore(score)
        end)
    end
end

function this:SetScore(score)
    local lv = 1
    if (score > s_mobie_height) then
        lv = 3
    elseif (score > s_mobie_middle) then
        lv = 2
    end
    PlayerPrefs.SetInt(s_mobie_lv_key, lv)
    PlayerPrefs.SetInt(s_mobie_score_key, score)
    SettingMgr:SaveValue(s_quality_key, lv)
    -- 高品质默认效果全开
    SettingMgr:SaveValue(s_toggle_zs_key, lv == 3 and 1 or 2)
    SettingMgr:SaveValue(s_toggle_mb_key, lv == 3 and 1 or 2)
    SettingMgr:SaveValue(s_toggle_jc_key, lv == 3 and 1 or 2)
    if lv == 3 then
        --CSAPI.SetTargetFrameRate(self:GetHighFPS())
        SettingMgr:SetHighFPS(true);
        CSAPI.SetShaderOutline(true)
        CSAPI.SetAA(true)
    end

    CSAPI.SetGameLv(lv)
    self.mobieLv = lv
    self.score = score
end

-- 机型等级  1：低端  2：中端  3：高端
function this:GetMobieLv()
    return self.mobieLv or s_quality_value, self.score or 0
end

-- 音乐开或关
function this:SetMusic(isOpen)
    local num = 0
    if (isOpen) then
        num = PlayerPrefs.GetInt(s_music_cache_key) or 0
    else
        local _value = SettingMgr:GetValue(s_audio_scale.music) or 0
        PlayerPrefs.SetInt(s_music_cache_key, _value)
    end
    SettingMgr:SetAudioScale(s_audio_scale.music, num)
end

-- 非手持设备（手机、平板）默认设置为最高画质
function this:SetMaxLv()
    local isEmulator = CSAPI.CheckEmulator()
    local devieModel = UnityEngine.SystemInfo.deviceModel
    local deviceType = CSAPI.GetDeviceType()
    if (CSAPI.IsIOS() or self:IsPad()) then
        local score = s_mobie_height + 1
        self:SetScore(score) --苹果设备直接设置为高配
        return true
    elseif (isEmulator or devieModel == "<unknown>" or deviceType ~= 1) then
        local score = s_mobie_height + 1
        self:SetScore(score)
        return true
    end
    return false
end

-- 是否是平板 -- 判断当前设备的对角线长度是否在平板设备的范围内
function this:IsPad()
    local deviceType = CSAPI.GetDeviceType()
    if (deviceType == 1) then
        local width = math.floor(CSAPI.GetMainCanvasSize()[0]) or 1
        local height = math.floor(CSAPI.GetMainCanvasSize()[1]) or 1
        local screenWidth = width / UnityEngine.Screen.dpi
        local screenHeight = height / UnityEngine.Screen.dpi
        local screenDiagonal = math.sqrt(screenWidth * screenWidth + screenHeight * screenHeight)
        local tabletDiagonalMin = 7.9 -- 以英寸为单位 2021/9月出产的最小的ipad是7.9英寸
        return screenDiagonal >= tabletDiagonalMin
    end
    return false
end

-- 语音文本 str
function this:GetSoundScript(soundCfg)
    if (self.datas[s_language_key] == 0) then
        return soundCfg.script1
    else
        return soundCfg.script2
    end
end

-- 是否是日语
function this:CheckIsJP()
    return self.datas[s_language_key] == 0
end

return this
