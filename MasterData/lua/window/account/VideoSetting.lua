local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local m_beginAdjustScreen, m_minNotch, m_maxNotch, m_oldSortOrder, m_oldValue

function Awake()
  WU.BindButtonEvent(REF.ButtonCustomDisplay, OnCustomDisplay)
  WU.BindPressEvent(REF.FPSControlTips, OnFPSControlTipsClick)
  this:RegisterGameEvent("SaveVideoSetting", OnSaveVideoSetting)
  CS.EventDelegate.Add(REF.ScreenSlider.UISlider.onChange, OnScreenSettingChange)
  WU.BindPressEvent(REF.SpriteUIAdjustRule, OnAdjustRulePress)
  WU.BindPressEvent(REF.ScreenThumb, function(go, pressed)
    if pressed then
      ToggleFakeCityUI()
    end
  end)
  REF.ScreenSlider.UISlider.onDragFinished = ToggleFakeCityUI
  WU.BindButtonEvent(REF.BtnSave, OnBtnSaveClick)
  WU.BindButtonEvent(REF.BtnCancel, OnBtnCancelClick)
end

function ToggleFakeCityUI()
  if not m_beginAdjustScreen then
    m_beginAdjustScreen = true
    m_oldSortOrder = REF.NodeScreenSize.UIPanel.sortingOrder
    REF.NodeScreenSize.UIPanel.sortingOrder = 29960
    WU.SetActive(REF.NodeBG, true)
  end
end

function Start()
  local preferences = m_configDataManager.GetPreferences()
  REF.ToggleFPSControl.UIToggle.value = preferences.fpsControl
  WU.BindButtonEvent(REF.ToggleFPSControl, OnToggleFPSControlClick)
  local settingValue = preferences.presetLevel
  local isCustom = m_configDataManager.IsPresetCustom(settingValue)
  REF.Preset.UIToggleGroup.value = settingValue
  REF.Preset.UIToggleGroup:Init(OnPresetChanged)
  REF.ButtonCustomDisplay.gameObject:SetActive(isCustom)
  InitScreenAdjustView()
end

function OnDisable()
  if m_beginAdjustScreen then
    m_beginAdjustScreen = false
    WU.SetActive(REF.NodeBG, false)
    REF.NodeScreenSize.UIPanel.sortingOrder = m_oldSortOrder
    REF.ScreenSlider.UISlider.value = m_oldValue
  end
end

function OnClick()
  WU.ShowHintText(WU.GetString("VideoSetting_PoorDeviceNotAllowed"))
end

function OnPresetChanged(obj)
  local presetLevel = REF.Preset.UIToggleGroup.value
  WU.RecordButtonClick(100137031 .. presetLevel)
  local isCustom = m_configDataManager.IsPresetCustom(presetLevel)
  REF.ButtonCustomDisplay.gameObject:SetActive(isCustom)
  if isCustom then
    local preferences = m_configDataManager.GetPreferences()
    preferences.presetLevel = 4
    if WU.IsPreCommit() then
      return
    end
    m_configDataManager.SetPreferences(preferences)
  end
end

function OnSaveVideoSetting()
  local updateSetting = false
  local presetLevel = REF.Preset.UIToggleGroup.value
  local preferences = m_configDataManager.GetPreferences()
  preferences.presetLevel = presetLevel
  if WU.IsPreCommit() then
    return
  end
  m_configDataManager.SetPreferences(preferences)
end

function OnToggleFPSControlClick()
  WU.RecordButtonClick(100137032 .. fif(REF.ToggleFPSControl.UIToggle.value, 1, 0))
  if REF.ToggleFPSControl.UIToggle.value then
    WU.ShowMessageYesNo(WU.GetString("Setting_FPSControl_Warining"), function(res)
      if res == "NO" then
        REF.ToggleFPSControl.UIToggle.value = false
      end
    end)
  end
end

function OnCustomDisplay()
  WU.RecordButtonClick(1001370314)
  local presetLevel = REF.Preset.UIToggleGroup.value
  local isCustom = m_configDataManager.IsPresetCustom(presetLevel)
  if isCustom then
    WU.AcquireWindowAsync("CustomDisplaySetting")
  end
end

function OnFPSControlTipsClick(go, pressed)
  local title = WU.GetString("Account_FPSControl")
  local desc = WU.GetString("Account_FPSControl_Hint")
  if pressed then
    WU.ShowHoverTips(title, desc)
  else
    WU.HideHoverTips()
  end
end

function InitScreenAdjustView()
  m_beginAdjustScreen = false
  WU.SetActive(REF.NodeBG, false)
  local screenSetting = PB.all("Misc"):first().screenSetting
  m_minNotch = screenSetting.minNotch or 0
  m_maxNotch = screenSetting.maxNotch
  local sliderRange = _ENV["$"](REF.ScreenSlider).Foreground.UISprite.width
  local x = (screenSetting.recommandNotch * 1.0 / (m_maxNotch - m_minNotch) - 0.5) * sliderRange
  REF.NodeRecommend.transform.localPosition = CS.UnityEngine.Vector3(x, 0, 0)
  local settingValue, notchWidth
  local notchWidth = CS.UIRoot.LeftNotchWidth
  if notchWidth then
    settingValue = (notchWidth - m_minNotch) * 1.0 / (m_maxNotch - m_minNotch)
  else
    settingValue = 0
    notchWidth = m_minNotch
    local preferences = m_configDataManager.GetPreferences()
    preferences.screenNotchSetting = {value = settingValue, width = notchWidth}
    m_configDataManager.SetPreferences(preferences)
  end
  m_oldValue = settingValue
  REF.ScreenSlider.UISlider.value = settingValue
end

function OnAdjustRulePress(go, pressed)
  WU.SetActive(REF.TextureAdjustRule, pressed)
end

function OnScreenSettingChange()
  local sliderValue = REF.ScreenSlider.UISlider.value
  local notchWidth = math.floor(m_minNotch + sliderValue * (m_maxNotch - m_minNotch))
  REF.NotchSize.UIWindowSize:ScreenSizeChangedWithNotch(notchWidth)
end

function OnBtnSaveClick()
  m_beginAdjustScreen = false
  WU.SetActive(REF.NodeBG, false)
  REF.NodeScreenSize.UIPanel.sortingOrder = m_oldSortOrder
  local sliderValue = REF.ScreenSlider.UISlider.value
  local change = math.abs(m_oldValue - sliderValue)
  if 0.01 < change then
    local notchWidth = math.floor(m_minNotch + sliderValue * (m_maxNotch - m_minNotch))
    local preferences = m_configDataManager.GetPreferences()
    m_oldValue = sliderValue
    preferences.screenNotchSetting = {value = sliderValue, width = notchWidth}
    m_configDataManager.SetPreferences(preferences)
    WU.ShowMessageYesNo(WU.GetString("Account_AdjustmentFinishTip"), function(result)
      if result == "YES" then
        CS.GameGlobal.Instance:ResetGame()
      end
    end)
  end
end

function OnBtnCancelClick()
  m_beginAdjustScreen = false
  WU.SetActive(REF.NodeBG, false)
  REF.NodeScreenSize.UIPanel.sortingOrder = m_oldSortOrder
  REF.ScreenSlider.UISlider.value = m_oldValue
end
