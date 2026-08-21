local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local PU = require("Common/PlatformUtil")
local m_configDataManager = S:Get("ConfigDataManager")

function Awake()
  if PU.IsRecordVideoSwitchOn() then
    WU.BindButtonEvent(REF.ButtonVideoList, function()
      WU.RecordButtonClick(1001370501)
      CS.RecordVideoManager.Instance:CheckSDKFeature(function(hasPermission)
        if hasPermission then
          CS.RecordVideoManager.Instance:ShowVideoListDialog()
        else
          WU.ShowHintText(WU.GetString("Platform_RecordVideoFailed"))
        end
      end)
    end)
  end
  if PU.IsRecordVideoSwitchOn() then
    local onChangedTriggeredByItsCallback = false
    local gachaOnChangedTriggeredByItsCallback = false
    CS.EventDelegate.Add(REF.ToggleRecordVideoSwitch.UIToggle.onChange, function()
      if not onChangedTriggeredByItsCallback then
        local enable = CS.UIToggle.current.value
        WU.RecordButtonClick(100137051 .. fif(enable, 1, 0))
        if enable then
          local preferences = m_configDataManager.GetPreferences()
          if preferences.recordVideo ~= true then
            REF["@ToggleRecordVideoSwitchEnabled"] = true
            CS.UIToggle.current.value = false
            CS.RecordVideoManager.Instance:CheckSDKFeature(function(hasPermission)
              onChangedTriggeredByItsCallback = true
              gachaOnChangedTriggeredByItsCallback = true
              REF.ToggleRecordVideoSwitch.UIToggle.value = hasPermission and REF["@ToggleRecordVideoSwitchEnabled"]
              if REF["@ToggleRecordGachaSwitchEnabled"] then
                REF.ToggleRecordGachaSwitch.UIToggle.value = hasPermission
              end
              if not hasPermission then
                WU.ShowHintText(WU.GetString("Platform_RecordVideoFailed"))
              end
              REF["@ToggleRecordVideoSwitchEnabled"] = false
              onChangedTriggeredByItsCallback = false
              gachaOnChangedTriggeredByItsCallback = false
            end)
          end
        end
      end
    end)
    CS.EventDelegate.Add(REF.ToggleRecordVideoHDSwitch.UIToggle.onChange, function()
      local enable = CS.UIToggle.current.value
      WU.RecordButtonClick(100137053 .. fif(enable, 1, 0))
      CS.RecordVideoManager.Instance:SetVideoQuality(enable)
    end)
    CS.EventDelegate.Add(REF.ToggleRecordGachaSwitch.UIToggle.onChange, function()
      if not gachaOnChangedTriggeredByItsCallback then
        local enable = CS.UIToggle.current.value
        WU.RecordButtonClick(100137052 .. fif(enable, 1, 0))
        if enable then
          local preferences = m_configDataManager.GetPreferences()
          if preferences.recordGacha ~= true then
            REF["@ToggleRecordGachaSwitchEnabled"] = true
            CS.UIToggle.current.value = false
            CS.RecordVideoManager.Instance:CheckSDKFeature(function(hasPermission)
              onChangedTriggeredByItsCallback = true
              gachaOnChangedTriggeredByItsCallback = true
              REF.ToggleRecordGachaSwitch.UIToggle.value = hasPermission and REF["@ToggleRecordGachaSwitchEnabled"]
              if REF["@ToggleRecordVideoSwitchEnabled"] then
                REF.ToggleRecordVideoSwitch.UIToggle.value = hasPermission
              end
              if not hasPermission then
                WU.ShowHintText(WU.GetString("Platform_RecordVideoFailed"))
              end
              REF["@ToggleRecordGachaSwitchEnabled"] = false
              onChangedTriggeredByItsCallback = false
              gachaOnChangedTriggeredByItsCallback = false
            end)
          end
        end
      end
    end)
  end
end

function OnEnable()
  local preferences = m_configDataManager.GetPreferences()
  REF.ToggleRecordVideoSwitch.UIToggle.value = preferences.recordVideo
  REF.ToggleRecordVideoHDSwitch.UIToggle.value = preferences.recordVideoHD
  REF.ToggleRecordGachaSwitch.UIToggle.value = preferences.recordGacha
end
