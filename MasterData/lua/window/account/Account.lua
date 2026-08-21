local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local PU = require("Common/PlatformUtil")
local m_baseInfo
local m_configDataManager = S:Get("ConfigDataManager")
local m_isLoginOut

function UpdateTabVisible()
  local switch = this:GetData("AccountSwitch")
  if switch and switch.GiftChange == false then
    REF.SettingTab4.gameObject:SetActive(false)
  else
    REF.SettingTab4.gameObject:SetActive(true)
  end
  REF.SettingTab5.gameObject:SetActive(PU.IsRecordVideoSwitchOn())
end

function InitWindow()
  UpdateTabVisible()
  this:Bind("fci/baseinfo/", OnSetBaseInfo)
  this:RegisterGameEvent("OnBindEntrySuccess", OnBindEntrySuccessEvent)
  this:RegisterGameEvent("OnChangeEntrySuccess", OnChangeEntrySuccessEvent)
  local accountCache = this:GetData("accountCache")
  WU.ToggleRendering(REF.LabelIsRealNameAccount, accountCache and accountCache.realnameFlag)
  REF.WidgetMySpaceReal["$SetPlayerDetail"](this:GetData("playerId"), true)
  for i = 0, #REF.SettingSwitch - 1 do
    REF.SettingSwitch[i]["$$SetClickCallback"](function()
      local n = i + 1
      WU.RecordButtonClick(1001370 .. n .. 0)
      if i == 2 then
        OnSystemSettingClick()
      else
        REF["$Animator"]:Play("Change", -1, 0)
      end
    end)
  end
  REF["$Animator"]:Play("Change", -1, 0)
end

function OnSystemSettingClick()
  local innerPrefab = "ContentSystemSetting"
  local widget = REF.ContentSystemSetting.transform:Find(innerPrefab)
  if widget == nil then
    local prefabPath = "Account/" .. innerPrefab
    widget = WU.InstantiateWindowPrefab(REF.ContentSystemSetting, prefabPath)
    WU.HandleGameObjectAttached(widget)
  end
  REF["$Animator"]:Play("Change", -1, 0)
end

function OnBackClick()
  WU.RecycleWindow("Account")
end

function UninitWindow()
  this:BroadcastGameEvent("SaveVideoSetting")
  if not m_isLoginOut then
    local preferences = m_configDataManager.GetPreferences()
    if not WU.IsPreCommit() and REF.ToggleUIUnload then
      preferences.memoryControl = REF.ToggleUIUnload.UIToggle.value
    end
    if REF.ToggleAuraReader then
      preferences.auraHintControl = REF.ToggleAuraReader.UIToggle.value
    end
    if REF.ToggleFPSControl then
      preferences.fpsControl = REF.ToggleFPSControl.UIToggle.value
    end
    if REF.ToggleEnergyFull then
      preferences.energyFull = REF.ToggleEnergyFull.UIToggle.value
    end
    if REF.ToggleDispatchBack then
      preferences.dispatchBack = REF.ToggleDispatchBack.UIToggle.value
    end
    if REF.ToggleDrawEnergy then
      preferences.drawEnergy = REF.ToggleDrawEnergy.UIToggle.value
    end
    if REF.ToggleRecordVideoSwitch then
      preferences.recordVideo = REF.ToggleRecordVideoSwitch.UIToggle.value
    end
    if REF.ToggleRecordVideoHDSwitch then
      preferences.recordVideoHD = REF.ToggleRecordVideoHDSwitch.UIToggle.value
    end
    if REF.ToggleRecordGachaSwitch then
      preferences.recordGacha = REF.ToggleRecordGachaSwitch.UIToggle.value
    end
    m_configDataManager.SetPreferences(preferences)
    this:BroadcastGameEvent("ResetNotification")
  end
  if PU.IsRecordVideoSwitchOn() then
    CS.RecordVideoManager.Instance:CloseVideoListDialog()
    CS.RecordVideoManager.Instance:ClearCheckFeatureCallbacks()
  end
end

function OnSetBaseInfo(baseInfo)
  if baseInfo then
    m_baseInfo = baseInfo
  end
end

function OnBindEntrySuccessEvent(msg)
  local accountCache = this:GetData("accountCache")
  if accountCache.entryType == "guest" then
    UpdateAccountCache(msg, true)
  end
end

function OnChangeEntrySuccessEvent(msg)
  local accountCache = this:GetData("accountCache")
  if msg.entryType == accountCache.entryType then
    UpdateAccountCache(msg, false)
  end
end

function UpdateAccountCache(msg, clearGuestEntry)
  local accountCache = this:GetData("accountCache")
  accountCache.accountEntry = msg.entry
  accountCache.entryType = msg.entryType
  accountCache.accessToken = msg.tokenAccess
  accountCache.expireTime = msg.createTime + msg.expireSeconds
  if clearGuestEntry then
    accountCache.GuestEntry = ""
  end
  this:BroadcastGameEvent("OnPreUpdateAccessToken")
  this:SetData("accountCache", accountCache)
end

function OnServiceTerms()
  WU.AcquireWindowAsync("ServiceTerms")
end

function SetNotifySettings()
  REF.SettingTab2["$SetSelected"]()
end

function SetVideoSettings()
  REF.SettingTab5["$SetSelected"]()
end

function OnLogout()
  m_isLoginOut = true
  local accountCache = this:GetData("accountCache")
  accountCache.accountId = ""
  accountCache.openId = ""
  accountCache.accessToken = ""
  accountCache.expireTime = 0
  this:SetData("accountCache", accountCache)
  CS.Msdk.WGPlatform.Instance:WGLogout()
  this:BroadcastGameEvent("ClearNotification")
  CS.GameGlobal.Instance:ResetGame()
end

function SetMySpace()
  REF.SettingTab1["$SetSelected"]()
end

function Focus(on)
  WU.RecordWindowFocus(100137, on)
end
