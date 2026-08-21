local PB = require("Common/PbHelper")
local S = require("Common/Singleton"):Register(_ENV, "ConfigDataManager")
local m_accountCachePath, m_preferencesPath, m_GameDataCachePath, m_preferences
local m_saltKeyHash = 0

function LoadPreferences()
  local resMgr = CS.ResourceManager.Instance
  local file = CS.System.IO.File
  m_saltKeyHash = CS.StringHash.CalculateHash(CS.UnityEngine.SystemInfo.deviceUniqueIdentifier)
  m_accountCachePath = resMgr:GetWritablePath("AccountCache")
  m_preferencesPath = resMgr:GetWritablePath("Preferences")
  m_GameDataCachePath = resMgr:GetWritablePath("GameDataCache")
  m_preferences = CS.LuaManager.Instance:LoadFromFile(m_preferencesPath, m_saltKeyHash)
  if m_preferences == nil then
    local score = CS.NativeInterface.External_GetPerformanceScore()
    local poorScore = 12000
    poorScore = 12000
    local isPoorDevice = score < poorScore
    local isLowMemory = isPoorDevice
    local ram = CS.NativeInterface.External_GetDeviceMemory()
    if ram < 2500000000 then
      isLowMemory = true
    end
    m_preferences = {
      currentLocale = 0,
      lastInstalledVersion = "",
      isAutoDeleteMail = true,
      isPoorDevice = isPoorDevice,
      memoryControl = isLowMemory,
      presetLevel = fif(isPoorDevice, 1, 2),
      fpsControl = true,
      auraHintControl = true
    }
  end
  local isDisableHD = false
  m_preferences.isDisableHD = isDisableHD
  if m_preferences.customSettings == nil then
    m_preferences.customSettings = GetPresetSettings(0)
  end
  if m_preferences.audioSetting == nil then
    m_preferences.audioSetting = {bgmVolume = 0.5, sfxVolume = 0.5}
  end
  if m_preferences.language == nil or m_preferences.language:len() == 0 then
    m_preferences.language = CS.ResourceManager.Instance.ConstConfig.DefaultLanguage
  end
  SetPreferences(m_preferences, true)
  this:Bind("accountCache", OnAccountCache)
  local accountCache = CS.LuaManager.Instance:LoadFromFile(m_accountCachePath, m_saltKeyHash) or {}
  this:SetData("accountCache", accountCache)
  this:Bind("gameDataCache", OnGameDataCache, false)
  local gameDataCache = CS.LuaManager.Instance:LoadFromFile(m_GameDataCachePath, m_saltKeyHash) or {}
  this:SetData("gameDataCache", gameDataCache)
end

function GetSalt()
  return m_saltKeyHash
end

function GetPreferences()
  return m_preferences
end

function SetPreferences(newPreferences, force)
  m_preferences = newPreferences
  if IsPresetCustom(m_preferences.presetLevel) then
    m_preferences.runtimeSettings = m_preferences.customSettings
  else
    m_preferences.runtimeSettings = GetPresetSettings(m_preferences.presetLevel)
  end
  m_preferences.runtimeSettings.targetFramerate = fif(m_preferences.fpsControl, 0, 1)
  this:SetData("config/gamePreferences", m_preferences)
  CS.LuaManager.Instance:SaveToFile(m_preferences, m_preferencesPath, m_saltKeyHash)
end

function IsPresetCustom(presetLevel)
  return presetLevel == 4
end

function GetPresetSettings(presetLevel)
  local presettings = PB.get("PresetSettings", presetLevel)
  if presettings ~= nil then
    return presettings.settings
  end
end

function OnAccountCache(account)
  if account ~= nil then
    CS.LuaManager.Instance:SaveToFile(account, m_accountCachePath, m_saltKeyHash)
  end
end

function OnGameDataCache(data)
  if data ~= nil then
    CS.LuaManager.Instance:SaveToFile(data, m_GameDataCachePath, m_saltKeyHash)
  end
end

function FullVersion()
  local versionInfo = CS.ResourceManager.Instance.VersionInfo
  return string.format("%s.%d", versionInfo.AppVersion, versionInfo.PatchVersion)
end

function Channel()
  return 0
end

function DeviceType()
  return PB.enum.GamePlatForm.Android
end

function ClientBasicInfo()
  local constConfig = CS.ResourceManager.Instance.ConstConfig
  return {
    appId = constConfig.AppId,
    appKey = constConfig.AppKey,
    device = CS.UnityEngine.SystemInfo.deviceModel,
    deviceId = CS.UnityEngine.SystemInfo.deviceUniqueIdentifier,
    deviceType = DeviceType(),
    channel = Channel(),
    clientVersion = FullVersion()
  }
end
