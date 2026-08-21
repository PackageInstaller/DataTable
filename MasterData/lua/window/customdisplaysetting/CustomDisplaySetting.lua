local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")

function SetupWindow()
end

function InitWindow()
  SetAllToggleShow()
end

function UninitWindow()
  OnSaveCustomDisplaySetting()
end

function SetToggleShow(setting, toggle)
  if setting == 1 then
    toggle.UIToggle.value = true
  else
    toggle.UIToggle.value = false
  end
  toggle.BoxCollider2D.enabled = true
end

function SetAllToggleShow()
  local settings = m_configDataManager.GetPreferences().customSettings
  if settings ~= nil then
    SetToggleShow(settings.roleQuality and settings.shadowQuality, REF.ToggleRoleEffect)
    SetToggleShow(settings.antiAlias and settings.postEffect, REF.ToggleSeniorEffect)
    SetToggleShow(settings.resolution, REF.ToggleHDQuality)
    SetToggleShow(settings.sceneEffect, REF.ToggleSceneEffect)
  end
  WU.BindButtonEvent(REF.ToggleHDQuality, function()
    WU.RecordButtonClick(10013751 .. fif(REF.ToggleHDQuality.UIToggle.value, 1, 0))
  end)
  WU.BindButtonEvent(REF.ToggleSeniorEffect, function()
    WU.RecordButtonClick(10013752 .. fif(REF.ToggleSeniorEffect.UIToggle.value, 1, 0))
  end)
  WU.BindButtonEvent(REF.ToggleRoleEffect, function()
    WU.RecordButtonClick(10013753 .. fif(REF.ToggleRoleEffect.UIToggle.value, 1, 0))
  end)
  WU.BindButtonEvent(REF.ToggleSceneEffect, function()
    WU.RecordButtonClick(10013754 .. fif(REF.ToggleSceneEffect.UIToggle.value, 1, 0))
  end)
end

function SwitchOneAndBool(value)
  if value == true then
    return 1
  else
    return 0
  end
end

function OnSaveCustomDisplaySetting()
  local preferences = m_configDataManager.GetPreferences()
  preferences.presetLevel = 4
  SaveCustomSettings(preferences)
  m_configDataManager.SetPreferences(preferences)
end

function SaveCustomSettings(preferences)
  preferences.customSettings = {
    roleQuality = SwitchOneAndBool(REF.ToggleRoleEffect.UIToggle.value),
    shadowQuality = SwitchOneAndBool(REF.ToggleRoleEffect.UIToggle.value),
    antiAlias = SwitchOneAndBool(REF.ToggleSeniorEffect.UIToggle.value),
    postEffect = SwitchOneAndBool(REF.ToggleSeniorEffect.UIToggle.value),
    sceneEffect = SwitchOneAndBool(REF.ToggleSceneEffect.UIToggle.value),
    resolution = SwitchOneAndBool(REF.ToggleHDQuality.UIToggle.value)
  }
end

function Focus(on)
  WU.RecordWindowFocus(1001375, on)
end
