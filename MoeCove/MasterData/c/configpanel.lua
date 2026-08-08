---@class ConfigPanel : ConfigPanel_Generate
---##################### 【ConfigPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ConfigPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ConfigPanel = require "ConfigPanel_Generate"

function ConfigPanel:InitLogic(data)
    self.configToggleEnum = {
        "screen",
        "sound",
        "battle",
    }

    --当前模式
    self.nowMode = "screen"

    --通用DOTween动画时间
    self.commonFadeTime = 0.5
end

function ConfigPanel:InitPanel()
    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.ConfigPanel)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        UIMgr.SetGameRTActive(true)
        UIMgr:closeUI(self)
    end)
    self:initSoundPanel()
end

--function ConfigPanel:StartCreating(time)
--
--end

--function ConfigPanel:StartEnter(time)
--
--end

--function ConfigPanel:StartRemoving(time)
--
--end

--function ConfigPanel:StartExit(time)
--
--end

function ConfigPanel:OnOpen(data, initiative)
    self:InitPanel()
    self:setConfigMode(self.nowMode)
    UIMgr.SetGameRTActive(false)
end

--初始化声音设置
function ConfigPanel:initSoundPanel()
    local bGMValue = PlayerPrefs.GetFloat(GE.LocalCustomDataKey.BGMValue) or 0
    self.bGMValueSlider.slider.value = bGMValue
    local sEValue = PlayerPrefs.GetFloat(GE.LocalCustomDataKey.SEValue) or 0
    self.sEValueSlider.slider.value = sEValue
    local cVValue = PlayerPrefs.GetFloat(GE.LocalCustomDataKey.CVValue) or 0
    self.cVValueSlider.slider.value = cVValue
    local mainValue = PlayerPrefs.GetFloat(GE.LocalCustomDataKey.AllValue) or 0
    self.mainVolumeSlider.slider.value = mainValue
    self.bGMValueText.text.text = math.floor(bGMValue * 100 + 0.5)
    self.sEValueText.text.text = math.floor(sEValue * 100 + 0.5)
    self.cVValueText.text.text = math.floor(cVValue * 100 + 0.5)
    self.mainVolumeText.text.text = math.floor(mainValue * 100 + 0.5)

    local bGMIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.BGMIsOn)
    local sEIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.SEIsOn)
    local cVIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.CVIsOn)
    local mainIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.AllIsOn)
    self.bGMValueSlider.slider.interactable = bGMIsOn == 1
    self.sEValueSlider.slider.interactable = sEIsOn == 1
    self.cVValueSlider.slider.interactable = cVIsOn == 1
    self.mainVolumeSlider.slider.interactable = mainIsOn == 1

    local needObj = bGMIsOn == 1 and self.bGMOn or self.bGMOff
    self.bGMState.rectTransform.anchoredPosition = needObj.rectTransform.anchoredPosition
    self.bGMState.offText.canvasGroup.alpha = 1 - bGMIsOn
    self.bGMState.onText.canvasGroup.alpha = bGMIsOn

    needObj = sEIsOn == 1 and self.sEOn or self.sEOff
    self.sEState.rectTransform.anchoredPosition = needObj.rectTransform.anchoredPosition
    self.sEState.offText.canvasGroup.alpha = 1 - sEIsOn
    self.sEState.onText.canvasGroup.alpha = sEIsOn

    needObj = cVIsOn == 1 and self.cVOn or self.cVOff
    self.cVState.rectTransform.anchoredPosition = needObj.rectTransform.anchoredPosition
    self.cVState.offText.canvasGroup.alpha = 1 - cVIsOn
    self.cVState.onText.canvasGroup.alpha = cVIsOn

    needObj = mainIsOn == 1 and self.mainVolumeOn or self.mainVolumeOff
    self.mainVolumeState.rectTransform.anchoredPosition = needObj.rectTransform.anchoredPosition
    self.mainVolumeState.offText.canvasGroup.alpha = 1 - mainIsOn
    self.mainVolumeState.onText.canvasGroup.alpha = mainIsOn

    --角色语音相关逻辑
    local needInitToggle = Me:getUserData().CharInitVoice == 1 and self.initCHSToggle or self.initJPToggle
    needInitToggle.toggle:SetIsOnWithoutNotify(true)
    self.initCHSToggle.label.text.text = "汉语配音"--TODO下载逻辑
    self.initJPToggle.label.text.text = "日语配音"
end

--刷新画面按钮状态
function ConfigPanel:refreshScreenBtns()
    local qualityLevel = QualitySettingsMgr:getQualityLevel()
    local qualityData = QualitySettingsMgr:getQualityData()

    local qualityLevelToggle = qualityLevel == GE.GraphicsQualityType.Low and self.qualityLevelBox.qualityLevelLowToggle or
                               (qualityLevel == GE.GraphicsQualityType.Medium and self.qualityLevelBox.qualityLevelMediumToggle or
                                (qualityLevel == GE.GraphicsQualityType.High and self.qualityLevelBox.qualityLevelHighToggle or
                                 (qualityLevel == GE.GraphicsQualityType.VeryHigh and self.qualityLevelBox.qualityLevelVeryHighToggle or self.qualityLevelBox.qualityLevelCustomToggle)))
    qualityLevelToggle.toggle:SetIsOnWithoutNotify(true)

    local shadowQualityToggle = qualityData.shadowResolution == GE.ShadowResolution.None and self.shadowBox.shadowCloseToggle or
                            (qualityData.shadowResolution == GE.ShadowResolution.Low and self.shadowBox.shadowLowToggle or
                              (qualityData.shadowResolution == GE.ShadowResolution.Medium and self.shadowBox.shadowMediumToggle or
                               (qualityData.shadowResolution == GE.ShadowResolution.High and self.shadowBox.shadowHighToggle or self.shadowBox.shadowVeryHighToggle)))
    shadowQualityToggle.toggle:SetIsOnWithoutNotify(true)

    if not GV.IsEditor then
        local currentResolution = QualitySettingsMgr:GetNativeResolution()
        self.resolutionBox.resolutionHDToggle.canvasGroup.alpha = currentResolution.y >= GE.ResolutionType.HD and 1 or 0.5
        self.resolutionBox.resolutionFHDToggle.canvasGroup.alpha = currentResolution.y >= GE.ResolutionType.FHD and 1 or 0.5
        self.resolutionBox.resolutionQHDToggle.canvasGroup.alpha = currentResolution.y >= GE.ResolutionType.QHD and 1 or 0.5
    end

    -- local resolutionToggle = qualityData.resolution == GE.ResolutionType.HD and self.resolutionBox.resolutionHDToggle or
    --                         (qualityData.resolution == GE.ResolutionType.FHD and self.resolutionBox.resolutionFHDToggle or
    --                         (qualityData.resolution == GE.ResolutionType.Origin and self.resolutionBox.resolutionOriginToggle or
    --                         self.resolutionBox.resolutionQHDToggle))
    -- resolutionToggle.toggle:SetIsOnWithoutNotify(true)

    local renderScaleToggle = qualityData.renderScale == GE.RenderScaleType.VeryLow and self.renderScaleBox.renderScaleVeryLowToggle or
                            (qualityData.renderScale == GE.RenderScaleType.Low and self.renderScaleBox.renderScaleLowToggle or
                            (qualityData.renderScale == GE.RenderScaleType.Medium and self.renderScaleBox.renderScaleMediumToggle or
                            (qualityData.renderScale == GE.RenderScaleType.High and self.renderScaleBox.renderScaleHighToggle or 
                            self.renderScaleBox.renderScaleVeryHighToggle)))
    renderScaleToggle.toggle:SetIsOnWithoutNotify(true)

    local textureQualityToggle = qualityData.textureQuality == GE.TextureQualityType.Low and self.textureQualityBox.textureQualityLowToggle or
                            (qualityData.textureQuality == GE.TextureQualityType.Medium and self.textureQualityBox.textureQualityMediumToggle or self.textureQualityBox.textureQualityHighToggle)
    textureQualityToggle.toggle:SetIsOnWithoutNotify(true)

    if not GV.IsEditor then
        local currentRefreshRate = QualitySettingsMgr:GetCurrentRefreshRate()
        -- self.frameRateBox.frameRate45Toggle.interactable = currentRefreshRate >= GE.FrameRateType.FPS45
        -- self.frameRateBox.frameRate60Toggle.interactable = currentRefreshRate >= GE.FrameRateType.FPS60
        -- self.frameRateBox.frameRate90Toggle.interactable = currentRefreshRate >= GE.FrameRateType.FPS90
        -- self.frameRateBox.frameRate120Toggle.interactable = currentRefreshRate >= GE.FrameRateType.FPS120
        self.frameRateBox.frameRate45Toggle.canvasGroup.alpha = currentRefreshRate >= GE.FrameRateType.FPS45 and 1 or 0.5
        self.frameRateBox.frameRate60Toggle.canvasGroup.alpha = currentRefreshRate >= GE.FrameRateType.FPS60 and 1 or 0.5
        self.frameRateBox.frameRate90Toggle.canvasGroup.alpha = currentRefreshRate >= GE.FrameRateType.FPS90 and 1 or 0.5
        self.frameRateBox.frameRate120Toggle.canvasGroup.alpha = currentRefreshRate >= GE.FrameRateType.FPS120 and 1 or 0.5
    end
    local frameRateToggle = qualityData.frameRate == GE.FrameRateType.FPS30 and self.frameRateBox.frameRate30Toggle or
                            (qualityData.frameRate == GE.FrameRateType.FPS45 and self.frameRateBox.frameRate45Toggle or
                            (qualityData.frameRate == GE.FrameRateType.FPS60 and self.frameRateBox.frameRate60Toggle or
                            (qualityData.frameRate == GE.FrameRateType.FPS90 and self.frameRateBox.frameRate90Toggle or self.frameRateBox.frameRate120Toggle)))
    frameRateToggle.toggle:SetIsOnWithoutNotify(true)

    -- local antiAliasingToggle = qualityData.antiAliasing == GE.AntiAliasingType.None and self.antiAliasingBox.antiAliasingCloseToggle or
    --                         (qualityData.antiAliasing == GE.AntiAliasingType.TimesTwo and self.antiAliasingBox.antiAliasingLowToggle or
    --                          (qualityData.antiAliasing == GE.AntiAliasingType.TimesFour and self.antiAliasingBox.antiAliasingMediumToggle or self.antiAliasingBox.antiAliasingHighToggle))
    -- antiAliasingToggle.toggle:SetIsOnWithoutNotify(true)
    local antiAliasingBtn = qualityData.antiAliasing == 1 and self.antiAliasingOn or self.antiAliasingOff
    self.antiAliasingState.rectTransform:DOAnchorPos(antiAliasingBtn.rectTransform.anchoredPosition, self.commonFadeTime)
    local isAntiAliasingOn = qualityData.antiAliasing
    isAntiAliasingOn = type(isAntiAliasingOn) == "boolean" and (isAntiAliasingOn and 1 or 0) or isAntiAliasingOn
    self.antiAliasingState.offText.canvasGroup:DOFade(1 - isAntiAliasingOn, self.commonFadeTime)
    self.antiAliasingState.onText.canvasGroup:DOFade(isAntiAliasingOn, self.commonFadeTime)

    local postProcessingBtn = qualityData.postProcessing == 1 and self.postProcessingOn or self.postProcessingOff
    self.postProcessingState.rectTransform:DOAnchorPos(postProcessingBtn.rectTransform.anchoredPosition, self.commonFadeTime)
    local isPostProcessingOn = qualityData.postProcessing
    isPostProcessingOn = type(isPostProcessingOn) == "boolean" and (isPostProcessingOn and 1 or 0) or isPostProcessingOn
    self.postProcessingState.offText.canvasGroup:DOFade(1 - isPostProcessingOn, self.commonFadeTime)
    self.postProcessingState.onText.canvasGroup:DOFade(isPostProcessingOn, self.commonFadeTime)

    local sceneOutlineBtn = qualityData.sceneOutline == 1 and self.sceneOutlineOn or self.sceneOutlineOff
    self.sceneOutlineState.rectTransform:DOAnchorPos(sceneOutlineBtn.rectTransform.anchoredPosition, self.commonFadeTime)
    local isSceneOutlineOn = qualityData.sceneOutline
    isSceneOutlineOn = type(isSceneOutlineOn) == "boolean" and (isSceneOutlineOn and 1 or 0) or isSceneOutlineOn
    self.sceneOutlineState.offText.canvasGroup:DOFade(1 - isSceneOutlineOn, self.commonFadeTime)
    self.sceneOutlineState.onText.canvasGroup:DOFade(isSceneOutlineOn, self.commonFadeTime)

    -- local waterRefractionBtn = qualityData.waterRefraction == 1 and self.waterRefractionOn or self.waterRefractionOff
    -- self.waterRefractionState.rectTransform:DOAnchorPos(waterRefractionBtn.rectTransform.anchoredPosition, self.commonFadeTime)
    -- local isWaterRefractionOn = qualityData.waterRefraction
    -- isWaterRefractionOn = type(isWaterRefractionOn) == "boolean" and (isWaterRefractionOn and 1 or 0) or isWaterRefractionOn
    -- self.waterRefractionState.offText.canvasGroup:DOFade(1 - isWaterRefractionOn, self.commonFadeTime)
    -- self.waterRefractionState.onText.canvasGroup:DOFade(isWaterRefractionOn, self.commonFadeTime)
    local waterQualityToggle = qualityData.waterQuality == GE.WaterQualityType.Low and self.waterRefractionBox.waterLowToggle or
                              (qualityData.waterQuality == GE.WaterQualityType.Medium and self.waterRefractionBox.waterMediumToggle or self.waterRefractionBox.waterHighToggle)
    waterQualityToggle.toggle:SetIsOnWithoutNotify(true)

    local adjustValue = PlayerPrefs.GetFloat(GE.LocalCustomDataKey.MaxAdjustValue) or 0

    --获取当前屏幕宽高比
    local currentScreenRatio = UnityEngine.Screen.width / UnityEngine.Screen.height
    local designScreenRatio = UIMgr.DesignWidth / UIMgr.DesignHeight
    self.adjustValueSlider.slider.interactable = currentScreenRatio > designScreenRatio
    self.adjustValueSlider.slider.value = currentScreenRatio > designScreenRatio and adjustValue or 1
end

function ConfigPanel:setConfigMode(newMode)
    if newMode == "screen" then
        --刷新画面按钮状态
        self:refreshScreenBtns()
    end

    self[self.nowMode.."Btn"].isSelect:SetActive(false)
    self[self.nowMode.."Panel"].canvasGroup.alpha = 0
    self[self.nowMode.."Panel"].canvasGroup.blocksRaycasts = false
    self[newMode.."Btn"].isSelect:SetActive(true)
    self[newMode.."Panel"].canvasGroup.alpha = 1
    self[newMode.."Panel"].canvasGroup.blocksRaycasts = true
    self.nowMode = newMode
end

--高分辨率开关
function ConfigPanel:SetHResolutionBtnFunc(btnObj)
    self.hResolutionState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.hResolutionState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.hResolutionState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--动态例会开关
function ConfigPanel:SetLive2DBtnFunc(btnObj)
    self.live2DState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.live2DState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.live2DState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--设置阴影效果
function ConfigPanel:SetShadowBtnFunc(btnObj)
    self.shadowState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isHight = string.find(btnObj.name, "High") and 1 or 0
    local isMiddle = string.find(btnObj.name, "Middle") and 1 or 0
    local isLow = string.find(btnObj.name, "Low") and 1 or 0
    self.shadowState.highText.canvasGroup:DOFade(isHight, self.commonFadeTime)
    self.shadowState.middleText.canvasGroup:DOFade(isMiddle, self.commonFadeTime)
    self.shadowState.lowText.canvasGroup:DOFade(isLow, self.commonFadeTime)

    self:setShadowQuality(isHight == 1 and 2048 or (isMiddle == 1 and 1024 or 512))
end

--主界面默认场景
function ConfigPanel:SetMainSceneBtnFunc(btnObj)
    self.mainSceneState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.mainSceneState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.mainSceneState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--战场网格线开关
function ConfigPanel:SetGridLineBtnFunc(btnObj)
    self.gridLineState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.gridLineState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.gridLineState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--视角锁定开关
function ConfigPanel:SetViewLockBtnFunc(btnObj)
    self.viewLockState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.viewLockState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.viewLockState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--透视开关
function ConfigPanel:SetPerspectiveBtnFunc(btnObj)
    self.perspectiveState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.perspectiveState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.perspectiveState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--生命值刻度开关
function ConfigPanel:SetHPTickMarkBtnFunc(btnObj)
    self.hPTickMarkState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.hPTickMarkState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.hPTickMarkState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--主音量开关
function ConfigPanel:SetMainVolumeBtnFunc(btnObj)
    self.mainVolumeState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.mainVolumeState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.mainVolumeState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    AudioMgr:SetMasterMute(isOn == 0)
    UnityEngine.PlayerPrefs.SetInt(GE.LocalCustomDataKey.AllIsOn, isOn)
    self.mainVolumeSlider.slider.interactable = isOn == 1
end

--音乐开关
function ConfigPanel:SetBGMBtnFunc(btnObj)
    self.bGMState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.bGMState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.bGMState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    AudioMgr:SetBGMMute(isOn == 0)
    UnityEngine.PlayerPrefs.SetInt(GE.LocalCustomDataKey.BGMIsOn, isOn)
    self.bGMValueSlider.slider.interactable = isOn == 1
end

--音效开关
function ConfigPanel:SetSEBtnFunc(btnObj)
    self.sEState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.sEState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.sEState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    AudioMgr:SetSEMute(isOn == 0)
    UnityEngine.PlayerPrefs.SetInt(GE.LocalCustomDataKey.SEIsOn, isOn)
    self.sEValueSlider.slider.interactable = isOn == 1
end

--语音开关
function ConfigPanel:SetCVBtnFunc(btnObj)
    self.cVState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.cVState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.cVState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    AudioMgr:SetVoiceMute(isOn == 0)
    UnityEngine.PlayerPrefs.SetInt(GE.LocalCustomDataKey.CVIsOn, isOn)
    self.cVValueSlider.slider.interactable = isOn == 1
end

--设置画质等级
---@param level GE.GraphicsQualityType
function ConfigPanel:setQualityLevel(level)
    local qualityLevel = QualitySettingsMgr:getQualityLevel()
    if qualityLevel == level then
        return
    end
    QualitySettingsMgr:changeSettingLevel(level)
    self:refreshScreenBtns()
    --埋点
        local tips = {
        [GE.GraphicsQualityType.Low] = "低",
        [GE.GraphicsQualityType.Medium] = "中",
        [GE.GraphicsQualityType.High] = "高",
        [GE.GraphicsQualityType.VeryHigh] = "超高",
        [GE.GraphicsQualityType.Custom] = "自定义",
    }
    local data = {
        qualityLevel = tips[level],
        event_type = 77
    }
    ClientData:sendDailyLogMessage(data)
end

--设置渲染倍率
---@param scale GE.RenderScaleType
function ConfigPanel:setRenderScale(scaleLevel)

    local qualityData = QualitySettingsMgr:getQualityData()
    if qualityData.renderScale == scaleLevel then
        return
    end

    QualitySettingsMgr:changeSettingData("renderScale", scaleLevel)
    QualitySettingsMgr:SetResolutionLevel(scaleLevel)
    self:refreshScreenBtns()
    --埋点
    local tips = {
        [GE.RenderScaleType.VeryLow] = "极低",
        [GE.RenderScaleType.Low] = "低",
        [GE.RenderScaleType.Medium] = "中",
        [GE.RenderScaleType.High] = "高",
        [GE.RenderScaleType.VeryHigh] = "极高",
    }
    local data = {
        renderScale = tips[scaleLevel],
        event_type = 77
    }
    -- ClientData:sendDailyLogMessage(data)
end

--设置分辨率 旧
---@param resolution GE.ResolutionType
function ConfigPanel:setResolution(resolution)
    local qualityData = QualitySettingsMgr:getQualityData()
    if qualityData.resolution == resolution then
        return
    end

    QualitySettingsMgr:changeSettingData("resolution", resolution)
    QualitySettingsMgr:SetResolution(resolution)
    self:refreshScreenBtns()
end

--设置帧率
---@param frameRate GE.FrameRateType
function ConfigPanel:setFrameRate(frameRate)
    local qualityData = QualitySettingsMgr:getQualityData()
    if qualityData.frameRate == frameRate then
        return
    end

    QualitySettingsMgr:changeSettingData("frameRate", frameRate)
    QualitySettingsMgr:SetFrameRate(frameRate)
    self:refreshScreenBtns()
    --埋点
    local tips = {
        [GE.FrameRateType.FPS30] = "30",
        [GE.FrameRateType.FPS45] = "45",
        [GE.FrameRateType.FPS60] = "60",
        [GE.FrameRateType.FPS90] = "90",
        [GE.FrameRateType.FPS120] = "120",
    }
    local data = {
        frameRate = tips[frameRate],
        event_type = 77
    }
    -- ClientData:sendDailyLogMessage(data)
end

--设置抗锯齿
---@param antiAliasing GE.AntiAliasingType
function ConfigPanel:setAntiAliasing(btnObj, antiAliasing)
    -- local qualityData = QualitySettingsMgr:getQualityData()
    -- if qualityData.antiAliasing == antiAliasing then
    --     return
    -- end

    -- QualitySettingsMgr:changeSettingData("antiAliasing", antiAliasing)
    -- QualitySettingsMgr:SetAntiAliasing(antiAliasing)
    -- self:refreshScreenBtns()

    self.antiAliasingState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = antiAliasing and 1 or 0
    self.antiAliasingState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.antiAliasingState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    QualitySettingsMgr:changeSettingData("antiAliasing", isOn)
    QualitySettingsMgr:SetAntiAliasing(antiAliasing)
    self:refreshScreenBtns()
    --埋点
    local tips = {
        [GE.AntiAliasingType.None] = "无",
        [GE.AntiAliasingType.TimesTwo] = "2倍采样",
        [GE.AntiAliasingType.TimesFour] = "4倍采样",
        [GE.AntiAliasingType.TimesEight] = "8倍采样",
    }
    local data = {
        antiAliasingLevel = tips[antiAliasing],
        event_type = 77
    }
    -- ClientData:sendDailyLogMessage(data)
end

--设置贴图质量
function ConfigPanel:setTextureQuality(textureQuality)
    local qualityData = QualitySettingsMgr:getQualityData()
    if qualityData.textureQuality == textureQuality then
        return
    end

    QualitySettingsMgr:changeSettingData("textureQuality", textureQuality)
    QualitySettingsMgr:SetTextureQuality(textureQuality)
    self:refreshScreenBtns()
    --埋点
    local tips = {
        [GE.TextureQualityType.Low] = "低",
        [GE.TextureQualityType.Medium] = "中",
        [GE.TextureQualityType.High] = "高",
    }
    local data = {
        textureLevel = tips[textureQuality],
        event_type = 77
    }
    -- ClientData:sendDailyLogMessage(data)
end

--设置阴影质量
function ConfigPanel:setShadowQuality(shadowResolution)
    local qualityData = QualitySettingsMgr:getQualityData()
    if qualityData.shadowResolution == shadowResolution then
        return
    end
    QualitySettingsMgr:changeSettingData("shadowResolution", shadowResolution)
    QualitySettingsMgr:SetShadowResolution(shadowResolution)
    self:refreshScreenBtns()
    --埋点
    local tips = {
        [GE.ShadowResolution.None] = "无阴影",
        [GE.ShadowResolution.Low] = "低",
        [GE.ShadowResolution.Medium] = "中",
        [GE.ShadowResolution.High] = "高",
        [GE.ShadowResolution.VeryHigh] = "超高",
    }
    local data = {
        shadowLevel = tips[shadowResolution],
        event_type = 77
    }
    -- ClientData:sendDailyLogMessage(data)
end

--设置后处理
function ConfigPanel:setPostProcessing(btnObj, postProcessing)
    self.postProcessingState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = postProcessing and 1 or 0
    self.postProcessingState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.postProcessingState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    QualitySettingsMgr:changeSettingData("postProcessing", isOn)
    QualitySettingsMgr:SetPostProcessing(postProcessing)
    self:refreshScreenBtns()
end

function ConfigPanel:setSceneOutline(btnObj, sceneOutline)
    self.sceneOutlineState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = sceneOutline and 1 or 0
    self.sceneOutlineState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.sceneOutlineState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    QualitySettingsMgr:changeSettingData("sceneOutline", isOn)
    QualitySettingsMgr:SetSceneOutline(sceneOutline)
    self:refreshScreenBtns()
end

--设置水面反射
-- function ConfigPanel:setWaterRefraction(btnObj, waterRefraction)
--     self.waterRefractionState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
--     local isOn = waterRefraction and 1 or 0
--     self.waterRefractionState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
--     self.waterRefractionState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

--     QualitySettingsMgr:changeSettingData("waterRefraction", isOn)
--     QualitySettingsMgr:SetWaterRefraction(waterRefraction)
--     self:refreshScreenBtns()
-- end

--设置水面质量
function ConfigPanel:setWaterQuality(waterQuality)
    local qualityData = QualitySettingsMgr:getQualityData()
    if qualityData.waterQuality == waterQuality then
        return
    end
    QualitySettingsMgr:changeSettingData("waterQuality", waterQuality)
    QualitySettingsMgr:SetWaterQuality(waterQuality)
    self:refreshScreenBtns()
    --埋点
    local tips = {
        [GE.WaterQualityType.Low] = "低",
        [GE.WaterQualityType.Medium] = "中",
        [GE.WaterQualityType.High] = "高",
    }
    local data = {
        waterQuality = tips[waterQuality],
        event_type = 77
    }
    -- ClientData:sendDailyLogMessage(data)
end

--设置界面调整
function ConfigPanel:setAdjustValue(value)
    UIMgr.SetMaxAdjustValue(value)
    UIMgr.SetCanvasRootPadding()
    PlayerPrefs.SetFloat(GE.LocalCustomDataKey.MaxAdjustValue, value)
end

function ConfigPanel:OnClose(initiative)
    UIMgr.SetGameRTActive(true)
end

--function ConfigPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ConfigPanel:OnRefresh(data)
--
--end

--[[
/PanelBox/SoundPanel/MainVolumeBox/MainVolumeSlider onValueChanged 
--]]
function ConfigPanel:mainVolumeSlider_Slider_onValueChanged(mainVolumeSlider,value)
    if mainVolumeSlider.slider.interactable then
        PlayerPrefs.SetFloat(GE.LocalCustomDataKey.AllValue, value)
        AudioMgr:setMasterVolume(value)
        self.mainVolumeText.text.text = math.floor(value * 100 + 0.5)
    end
end

--[[
/BgPanel/BGMValueSlider onValueChanged 
--]]
function ConfigPanel:bGMValueSlider_Slider_onValueChanged(bGMValueSlider,value)
    if bGMValueSlider.slider.interactable then
        PlayerPrefs.SetFloat(GE.LocalCustomDataKey.BGMValue, value)
        AudioMgr:setBGMVolume(value)
        self.bGMValueText.text.text = math.floor(value * 100 + 0.5)
    end
end

--[[
/BgPanel/SEValueSlider onValueChanged 
--]]
function ConfigPanel:sEValueSlider_Slider_onValueChanged(sEValueSlider,value)
    if sEValueSlider.slider.interactable then
        PlayerPrefs.SetFloat(GE.LocalCustomDataKey.SEValue, value)
        AudioMgr:setSEVolume(value)
        self.sEValueText.text.text = math.floor(value * 100 + 0.5)
    end
end

--[[
/BgPanel/CVValueSlider onValueChanged 
--]]
function ConfigPanel:cVValueSlider_Slider_onValueChanged(cVValueSlider,value)
    if cVValueSlider.slider.interactable then
        PlayerPrefs.SetFloat(GE.LocalCustomDataKey.CVValue, value)
        AudioMgr:setCVVolume(value)
        self.cVValueText.text.text = math.floor(value * 100 + 0.5)
    end
end

--[[
/ToggleList/ScreenBtn onClick 
--]]
function ConfigPanel:screenBtn_ScaleButton_onClick(screenBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setConfigMode("screen")
end

--[[
/ToggleList/SoundBtn onClick 
--]]
function ConfigPanel:soundBtn_ScaleButton_onClick(soundBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setConfigMode("sound")
end

--[[
/ToggleList/BattleBtn onClick 
--]]
function ConfigPanel:battleBtn_ScaleButton_onClick(battleBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setConfigMode("battle")
end

--[[
/HightResolutionBox/BtnGroup/HResolutionOn onClick 
--]]
function ConfigPanel:hResolutionOn_Button_onClick(hResolutionOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --高分辨率开
    self:SetHResolutionBtnFunc(hResolutionOn)
end

--[[
/HightResolutionBox/BtnGroup/HResolutionOff onClick 
--]] 
function ConfigPanel:hResolutionOff_Button_onClick(hResolutionOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --高分辨率关
    self:SetHResolutionBtnFunc(hResolutionOff)
end
 

--[[
/PanelBox/ScreenPanel/Live2DBox/BtnGroup/Live2DOn onClick 
--]]
function ConfigPanel:live2DOn_Button_onClick(live2DOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --动态例会开
    self:SetLive2DBtnFunc(live2DOn)
end

--[[
/PanelBox/ScreenPanel/Live2DBox/BtnGroup/Live2DOff onClick 
--]]
function ConfigPanel:live2DOff_Button_onClick(live2DOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --动态例会关
    self:SetLive2DBtnFunc(live2DOff)
end

--[[
/PanelBox/ScreenPanel/MainSceneBox/BtnGroup/MainSceneOn onClick 
--]]
function ConfigPanel:mainSceneOn_Button_onClick(mainSceneOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --默认办公室场景
    self:SetMainSceneBtnFunc(mainSceneOn)
end

--[[
/PanelBox/ScreenPanel/MainSceneBox/BtnGroup/MainSceneOff onClick 
--]]
function ConfigPanel:mainSceneOff_Button_onClick(mainSceneOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --默认家园场景
    self:SetMainSceneBtnFunc(mainSceneOff)
end

--[[
/PanelBox/BattlePanel/GridLineBox/BtnGroup/GridLineOn onClick 
--]]
function ConfigPanel:gridLineOn_Button_onClick(gridLineOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --战场网格线开
    self:SetGridLineBtnFunc(gridLineOn)
end

--[[
/PanelBox/BattlePanel/GridLineBox/BtnGroup/GridLineOff onClick 
--]]
function ConfigPanel:gridLineOff_Button_onClick(gridLineOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --战场网格线关
    self:SetGridLineBtnFunc(gridLineOff)
end

--[[
/PanelBox/BattlePanel/ViewLockBox/BtnGroup/ViewLockOn onClick 
--]]
function ConfigPanel:viewLockOn_Button_onClick(viewLockOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --视角锁定开
    self:SetViewLockBtnFunc(viewLockOn)
end

--[[
/PanelBox/BattlePanel/ViewLockBox/BtnGroup/ViewLockOff onClick 
--]]
function ConfigPanel:viewLockOff_Button_onClick(viewLockOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --视角锁定关
    self:SetViewLockBtnFunc(viewLockOff)
end

--[[
/PanelBox/BattlePanel/PerspectiveBox/BtnGroup/PerspectiveOn onClick 
--]]
function ConfigPanel:perspectiveOn_Button_onClick(perspectiveOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --透视开
    self:SetPerspectiveBtnFunc(perspectiveOn)
end

--[[
/PanelBox/BattlePanel/PerspectiveBox/BtnGroup/PerspectiveOff onClick 
--]]
function ConfigPanel:perspectiveOff_Button_onClick(perspectiveOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --透视关
    self:SetPerspectiveBtnFunc(perspectiveOff)
end

--[[
/PanelBox/BattlePanel/HPTickMarkBox/BtnGroup/HPTickMarkOn onClick 
--]]
function ConfigPanel:hPTickMarkOn_Button_onClick(hPTickMarkOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --生命值刻度开
    self:SetHPTickMarkBtnFunc(hPTickMarkOn)
end

--[[
/PanelBox/BattlePanel/HPTickMarkBox/BtnGroup/HPTickMarkOff onClick 
--]]
function ConfigPanel:hPTickMarkOff_Button_onClick(hPTickMarkOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --生命值刻度关
    self:SetHPTickMarkBtnFunc(hPTickMarkOff)
end

--[[
/PanelBox/SoundPanel/MainVolumeBox/BtnGroup/MainVolumeOn onClick 
--]]
function ConfigPanel:mainVolumeOn_Button_onClick(mainVolumeOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetMainVolumeBtnFunc(mainVolumeOn)
end

--[[
/PanelBox/SoundPanel/MainVolumeBox/BtnGroup/MainVolumeOff onClick 
--]]
function ConfigPanel:mainVolumeOff_Button_onClick(mainVolumeOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetMainVolumeBtnFunc(mainVolumeOff)
end

--[[
/PanelBox/SoundPanel/BGMBox/BtnGroup/BGMOn onClick 
--]]
function ConfigPanel:bGMOn_Button_onClick(bGMOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetBGMBtnFunc(bGMOn)
end

--[[
/PanelBox/SoundPanel/BGMBox/BtnGroup/BGMOff onClick 
--]]
function ConfigPanel:bGMOff_Button_onClick(bGMOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetBGMBtnFunc(bGMOff)
end

--[[
/PanelBox/SoundPanel/SEBox/BtnGroup/SEOn onClick 
--]]
function ConfigPanel:sEOn_Button_onClick(sEOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetSEBtnFunc(sEOn)
end

--[[
/PanelBox/SoundPanel/SEBox/BtnGroup/SEOff onClick 
--]]
function ConfigPanel:sEOff_Button_onClick(sEOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetSEBtnFunc(sEOff)
end

--[[
/PanelBox/SoundPanel/CVBox/BtnGroup/CVOn onClick 
--]]
function ConfigPanel:cVOn_Button_onClick(cVOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetCVBtnFunc(cVOn)
end

--[[
/PanelBox/SoundPanel/CVBox/BtnGroup/CVOff onClick 
--]]
function ConfigPanel:cVOff_Button_onClick(cVOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetCVBtnFunc(cVOff)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ParticleBox/BtnGroup/ParticleLow onClick 
--]]
function ConfigPanel:particleLow_Button_onClick(particleLow)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ParticleBox/BtnGroup/ParticleMiddle onClick 
--]]
function ConfigPanel:particleMiddle_Button_onClick(particleMiddle)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ParticleBox/BtnGroup/ParticleHigh onClick 
--]]
function ConfigPanel:particleHigh_Button_onClick(particleHigh)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/PostProcessingBox/BtnGroup/PostProcessingOn onClick 
--]]
function ConfigPanel:postProcessingOn_Button_onClick(postProcessingOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --后处理开
    self:setPostProcessing(postProcessingOn, true)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/PostProcessingBox/BtnGroup/PostProcessingOff onClick 
--]]
function ConfigPanel:postProcessingOff_Button_onClick(postProcessingOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --后处理关
    self:setPostProcessing(postProcessingOff, false)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/WaterRefractionBox/BtnGroup/WaterRefractionOn onClick 
--]]
function ConfigPanel:waterRefractionOn_Button_onClick(waterRefractionOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --水面反射开
    self:setWaterRefraction(waterRefractionOn, true)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/WaterRefractionBox/BtnGroup/WaterRefractionOff onClick 
--]]
function ConfigPanel:waterRefractionOff_Button_onClick(waterRefractionOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --水面反射关
    self:setWaterRefraction(waterRefractionOff, false)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/QualityLevelBox/ToggleGroup/QualityLevelLowToggle onValueChanged 
--]]
function ConfigPanel:qualityLevelLowToggle_Toggle_onValueChanged(qualityLevelLowToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setQualityLevel(GE.GraphicsQualityType.Low)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/QualityLevelBox/ToggleGroup/QualityLevelMediumToggle onValueChanged 
--]]
function ConfigPanel:qualityLevelMediumToggle_Toggle_onValueChanged(qualityLevelMediumToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setQualityLevel(GE.GraphicsQualityType.Medium)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/QualityLevelBox/ToggleGroup/QualityLevelHighToggle onValueChanged 
--]]
function ConfigPanel:qualityLevelHighToggle_Toggle_onValueChanged(qualityLevelHighToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setQualityLevel(GE.GraphicsQualityType.High)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/QualityLevelBox/ToggleGroup/QualityLevelVeryHighToggle onValueChanged 
--]]
function ConfigPanel:qualityLevelVeryHighToggle_Toggle_onValueChanged(qualityLevelVeryHighToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setQualityLevel(GE.GraphicsQualityType.VeryHigh)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/QualityLevelBox/ToggleGroup/QualityLevelCustomToggle onValueChanged 
--]]
function ConfigPanel:qualityLevelCustomToggle_Toggle_onValueChanged(qualityLevelCustomToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setQualityLevel(GE.GraphicsQualityType.Custom)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ShadowBox/ToggleGroup/ShadowCloseToggle onValueChanged 
--]]
function ConfigPanel:shadowCloseToggle_Toggle_onValueChanged(shadowCloseToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setShadowQuality(GE.ShadowResolution.None)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ShadowBox/ToggleGroup/ShadowLowToggle onValueChanged 
--]]
function ConfigPanel:shadowLowToggle_Toggle_onValueChanged(shadowLowToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setShadowQuality(GE.ShadowResolution.Low)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ShadowBox/ToggleGroup/ShadowMediumToggle onValueChanged 
--]]
function ConfigPanel:shadowMediumToggle_Toggle_onValueChanged(shadowMediumToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setShadowQuality(GE.ShadowResolution.Medium)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ShadowBox/ToggleGroup/ShadowHighToggle onValueChanged 
--]]
function ConfigPanel:shadowHighToggle_Toggle_onValueChanged(shadowHighToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setShadowQuality(GE.ShadowResolution.High)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ShadowBox/ToggleGroup/ShadowVeryHighToggle onValueChanged 
--]]
function ConfigPanel:shadowVeryHighToggle_Toggle_onValueChanged(shadowVeryHighToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setShadowQuality(GE.ShadowResolution.VeryHigh)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ResolutionBox/ToggleGroup/ResolutionHDToggle onValueChanged 
--]]
function ConfigPanel:resolutionHDToggle_Toggle_onValueChanged(resolutionHDToggle,isOn)
    if isOn then
        local currentResolution = QualitySettingsMgr:GetNativeResolution()
        if not GV.IsEditor and currentResolution.y < GE.ResolutionType.HD then
            self:refreshScreenBtns()
            return
        end
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setResolution(GE.ResolutionType.HD)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ResolutionBox/ToggleGroup/ResolutionFHDToggle onValueChanged 
--]]
function ConfigPanel:resolutionFHDToggle_Toggle_onValueChanged(resolutionFHDToggle,isOn)
    if isOn then
        local currentResolution = QualitySettingsMgr:GetNativeResolution()
        if not GV.IsEditor and currentResolution.y < GE.ResolutionType.FHD then
            self:refreshScreenBtns()
            return
        end
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setResolution(GE.ResolutionType.FHD)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ResolutionBox/ToggleGroup/ResolutionQHDToggle onValueChanged 
--]]
function ConfigPanel:resolutionQHDToggle_Toggle_onValueChanged(resolutionQHDToggle,isOn)
    if isOn then
        local currentResolution = QualitySettingsMgr:GetNativeResolution()
        if not GV.IsEditor and currentResolution.y < GE.ResolutionType.QHD then
            self:refreshScreenBtns()
            return
        end
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setResolution(GE.ResolutionType.QHD)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/RenderScaleBox/ToggleGroup/RenderScaleLowToggle onValueChanged 
--]]
function ConfigPanel:renderScaleLowToggle_Toggle_onValueChanged(renderScaleLowToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setRenderScale(GE.RenderScaleType.Low)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/RenderScaleBox/ToggleGroup/RenderScaleMediumToggle onValueChanged 
--]]
function ConfigPanel:renderScaleMediumToggle_Toggle_onValueChanged(renderScaleMediumToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setRenderScale(GE.RenderScaleType.Medium)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/RenderScaleBox/ToggleGroup/RenderScaleHighToggle onValueChanged 
--]]
function ConfigPanel:renderScaleHighToggle_Toggle_onValueChanged(renderScaleHighToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setRenderScale(GE.RenderScaleType.High)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/TextureQualityBox/ToggleGroup/TextureQualityLowToggle onValueChanged 
--]]
function ConfigPanel:textureQualityLowToggle_Toggle_onValueChanged(textureQualityLowToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setTextureQuality(GE.TextureQualityType.Low)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/TextureQualityBox/ToggleGroup/TextureQualityMediumToggle onValueChanged 
--]]
function ConfigPanel:textureQualityMediumToggle_Toggle_onValueChanged(textureQualityMediumToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setTextureQuality(GE.TextureQualityType.Medium)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/TextureQualityBox/ToggleGroup/TextureQualityHighToggle onValueChanged 
--]]
function ConfigPanel:textureQualityHighToggle_Toggle_onValueChanged(textureQualityHighToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setTextureQuality(GE.TextureQualityType.High)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/FrameRateBox/ToggleGroup/FrameRate30Toggle onValueChanged 
--]]
function ConfigPanel:frameRate30Toggle_Toggle_onValueChanged(frameRate30Toggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setFrameRate(GE.FrameRateType.FPS30)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/FrameRateBox/ToggleGroup/FrameRate45Toggle onValueChanged 
--]]
function ConfigPanel:frameRate45Toggle_Toggle_onValueChanged(frameRate45Toggle,isOn)
    if isOn then
        local currentRefreshRate = QualitySettingsMgr:GetCurrentRefreshRate()
        if not GV.IsEditor and currentRefreshRate < GE.FrameRateType.FPS45 then
            self:refreshScreenBtns()
            return
        end
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setFrameRate(GE.FrameRateType.FPS45)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/FrameRateBox/ToggleGroup/FrameRate60Toggle onValueChanged 
--]]
function ConfigPanel:frameRate60Toggle_Toggle_onValueChanged(frameRate60Toggle,isOn)
    if isOn then
        local currentRefreshRate = QualitySettingsMgr:GetCurrentRefreshRate()
        if not GV.IsEditor and currentRefreshRate < GE.FrameRateType.FPS60 then
            self:refreshScreenBtns()
            return
        end
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setFrameRate(GE.FrameRateType.FPS60)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/FrameRateBox/ToggleGroup/FrameRate90Toggle onValueChanged 
--]]
function ConfigPanel:frameRate90Toggle_Toggle_onValueChanged(frameRate90Toggle,isOn)
    if isOn then
        local currentRefreshRate = QualitySettingsMgr:GetCurrentRefreshRate()
        if not GV.IsEditor and currentRefreshRate < GE.FrameRateType.FPS90 then
            self:refreshScreenBtns()
            return
        end
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setFrameRate(GE.FrameRateType.FPS90)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/FrameRateBox/ToggleGroup/FrameRate120Toggle onValueChanged 
--]]
function ConfigPanel:frameRate120Toggle_Toggle_onValueChanged(frameRate120Toggle,isOn)
    if isOn then
        local currentRefreshRate = QualitySettingsMgr:GetCurrentRefreshRate()
        if not GV.IsEditor and currentRefreshRate < GE.FrameRateType.FPS120 then
            self:refreshScreenBtns()
            return
        end
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setFrameRate(GE.FrameRateType.FPS120)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/AntiAliasingBox/ToggleGroup/AntiAliasingCloseToggle onValueChanged 
--]]
function ConfigPanel:antiAliasingCloseToggle_Toggle_onValueChanged(antiAliasingCloseToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setAntiAliasing(GE.AntiAliasingType.None)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/AntiAliasingBox/ToggleGroup/AntiAliasingLowToggle onValueChanged 
--]]
function ConfigPanel:antiAliasingLowToggle_Toggle_onValueChanged(antiAliasingLowToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setAntiAliasing(GE.AntiAliasingType.TimesTwo)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/AntiAliasingBox/ToggleGroup/AntiAliasingMediumToggle onValueChanged 
--]]
function ConfigPanel:antiAliasingMediumToggle_Toggle_onValueChanged(antiAliasingMediumToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setAntiAliasing(GE.AntiAliasingType.TimesFour)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/AntiAliasingBox/ToggleGroup/AntiAliasingHighToggle onValueChanged 
--]]
function ConfigPanel:antiAliasingHighToggle_Toggle_onValueChanged(antiAliasingHighToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setAntiAliasing(GE.AntiAliasingType.TimesEight)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/ResolutionBox/ToggleGroup/ResolutionOriginToggle onValueChanged 
--]]
function ConfigPanel:resolutionOriginToggle_Toggle_onValueChanged(resolutionOriginToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setResolution(GE.ResolutionType.Origin)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/AntiAliasingBox/BtnGroup/AntiAliasingOn onClick 
--]]
function ConfigPanel:antiAliasingOn_Button_onClick(antiAliasingOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --抗锯齿开
    self:setAntiAliasing(antiAliasingOn, true)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/AntiAliasingBox/BtnGroup/AntiAliasingOff onClick 
--]]
function ConfigPanel:antiAliasingOff_Button_onClick(antiAliasingOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --抗锯齿关
    self:setAntiAliasing(antiAliasingOff, false)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/AdjustBox/AdjustValueSlider onValueChanged 
--]]
function ConfigPanel:adjustValueSlider_Slider_onValueChanged(adjustValueSlider,value)
    --界面适配
    if adjustValueSlider.slider.interactable then
        self:setAdjustValue(value)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/WaterRefractionBox/ToggleGroup/WaterLowToggle onValueChanged 
--]]
function ConfigPanel:waterLowToggle_Toggle_onValueChanged(waterLowToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --水面质量低
    self:setWaterQuality(GE.WaterQualityType.Low)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/WaterRefractionBox/ToggleGroup/WaterMediumToggle onValueChanged 
--]]
function ConfigPanel:waterMediumToggle_Toggle_onValueChanged(waterMediumToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --水面质量中
    self:setWaterQuality(GE.WaterQualityType.Medium)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/WaterRefractionBox/ToggleGroup/WaterHighToggle onValueChanged 
--]]
function ConfigPanel:waterHighToggle_Toggle_onValueChanged(waterHighToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --水面质量高
    self:setWaterQuality(GE.WaterQualityType.High)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/RenderScaleBox/ToggleGroup/RenderScaleVeryLowToggle onValueChanged 
--]]
function ConfigPanel:renderScaleVeryLowToggle_Toggle_onValueChanged(renderScaleVeryLowToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setRenderScale(GE.RenderScaleType.VeryLow)
    end
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/RenderScaleBox/ToggleGroup/RenderScaleVeryHighToggle onValueChanged 
--]]
function ConfigPanel:renderScaleVeryHighToggle_Toggle_onValueChanged(renderScaleVeryHighToggle,isOn)
    if isOn then
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:setRenderScale(GE.RenderScaleType.VeryHigh)
    end
end

--[[
/PanelBox/SoundPanel/Viewport/Content/VoiceResBox/DLCHSResToggle onValueChanged 
--]]
function ConfigPanel:dLCHSResToggle_Toggle_onValueChanged(dLCHSResToggle,isOn)

end

--[[
/PanelBox/SoundPanel/Viewport/Content/VoiceResBox/DLJPResToggle onValueChanged 
--]]
function ConfigPanel:dLJPResToggle_Toggle_onValueChanged(dLJPResToggle,isOn)

end

--[[
/PanelBox/SoundPanel/Viewport/Content/InitVoiceBox/InitCHSToggle onValueChanged 
--]]
function ConfigPanel:initCHSToggle_Toggle_onValueChanged(initCHSToggle,isOn)
    local initVoiceType = Me:getUserData().CharInitVoice
    if initVoiceType ~= GE.RoleLanguage.CHS then
        Me:setCharInitVoiceReq(GE.RoleLanguage.CHS)
    end
end

--[[
/PanelBox/SoundPanel/Viewport/Content/InitVoiceBox/InitJPToggle onValueChanged 
--]]
function ConfigPanel:initJPToggle_Toggle_onValueChanged(initJPToggle,isOn)
    local initVoiceType = Me:getUserData().CharInitVoice
    if initVoiceType ~= GE.RoleLanguage.JP then
        Me:setCharInitVoiceReq(GE.RoleLanguage.JP)
    end
end

--[[
/PanelBox/SoundPanel/Viewport/Content/SetVoiceBox/SetCHSBtn onClick 
--]]
function ConfigPanel:setCHSBtn_ScaleButton_onClick(setCHSBtn)
    Me:setCharVoiceReq({idList = {}, type = GE.RoleLanguage.CHS}, function ()
        UICommonUtils.PopToast("设置成功！")
    end)
end

--[[
/PanelBox/SoundPanel/Viewport/Content/SetVoiceBox/SetJPBtn onClick 
--]]
function ConfigPanel:setJPBtn_ScaleButton_onClick(setJPBtn)
    Me:setCharVoiceReq({idList = {}, type = GE.RoleLanguage.JP}, function ()
        UICommonUtils.PopToast("设置成功！")
    end)
end

--[[
/PanelBox/SoundPanel/Viewport/Content/SetVoiceBox/SetSPBtn onClick 
--]]
function ConfigPanel:setSPBtn_ScaleButton_onClick(setSPBtn)
    Me:setCharVoiceReq({idList = {}, type = GE.RoleLanguage.Special}, function ()
        UICommonUtils.PopToast("设置成功！")
    end)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/SceneOutlineBox/BtnGroup/SceneOutlineOn onClick 
--]]
function ConfigPanel:sceneOutlineOn_Button_onClick(sceneOutlineOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --场景描边开
    self:setSceneOutline(sceneOutlineOn, true)
end

--[[
/PanelBox/ScreenPanel/Viewport/Content/SceneOutlineBox/BtnGroup/SceneOutlineOff onClick 
--]]
function ConfigPanel:sceneOutlineOff_Button_onClick(sceneOutlineOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --场景描边关
    self:setSceneOutline(sceneOutlineOff, false)
end

return ConfigPanel
