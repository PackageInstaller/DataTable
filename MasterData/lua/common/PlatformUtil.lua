local PB = require("Common/PbHelper")
local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local rapidjson = require("rapidjson")
local PU = {}

function PU.IsPlatformOfQQ()
  local result = false
  local accountCache = DB:GetData("accountCache")
  result = accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ
  return result
end

function PU.IsPlatformOfWX()
  local result = false
  local accountCache = DB:GetData("accountCache")
  result = accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat
  return result
end

function PU.IsRecordVideoSwitchOn()
  local result = false
  local switch = DB:GetData("AccountSwitch")
  if not WU.IsPreCommit() then
    local accountCache = DB:GetData("accountCache")
    if accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ or accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
      result = true
    end
  end
  return result
end

function PU.IsRecordVideoEnabled()
  local result = false
  if PU.IsRecordVideoSwitchOn() then
    local preferences = m_configDataManager.GetPreferences()
    if preferences.recordVideo then
      result = true
    end
  end
  return result
end

function PU.IsRecordGachaEnabled()
  local result = false
  if PU.IsRecordVideoSwitchOn() then
    local preferences = m_configDataManager.GetPreferences()
    if preferences.recordGacha then
      result = true
    end
  end
  return result
end

function PU.GetQQAppId()
  return "1106429722"
end

function PU.GetWXAppId()
  return "wx687f4629ba7c3086"
end

function PU.GetAppId()
  local accountCache = DB:GetData("accountCache")
  if accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
    return PU.GetQQAppId()
  end
  if accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
    return PU.GetWXAppId()
  end
end

function PU.GetScreenOffsetPix(verticalOffsetDesighPix)
  local screenHeight = CS.UnityEngine.Screen.height
  local screenWidth = CS.UnityEngine.Screen.width
  local currentAspect = screenWidth / screenHeight
  local designAspect = CS.UIBaseProcess.DesignAspect
  local aspectRate = math.min(currentAspect / designAspect, 1)
  local screenOffsetPix = math.floor((1 - aspectRate) * 0.5 * screenHeight)
  local verticalOffsetPix = math.floor(verticalOffsetDesighPix / CS.UIBaseProcess.DesignHeight * (screenHeight - 2 * screenOffsetPix))
  return screenOffsetPix, verticalOffsetPix
end

function PU.ShowXYView(isShow)
  if isShow then
    local timestamp = CS.GameTime.serverUtc
    local accountCache = DB:GetData("accountCache")
    local params = {
      accessToken = accountCache.accessToken,
      timeStamp = timestamp .. "",
      sig = CS.UnityHTTP.Ext.ToMD5("ea8664ab1c8c7b8f2bd5bcd431ec0ad7" .. timestamp),
      enc = "2",
      loginType = fif(accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat, "1", "0"),
      openId = DB:GetData("SocialOpenId"),
      appId = PU.GetAppId(),
      gameId = "1285",
      source = "xy_sdk",
      partitionId = DB:GetData("worldId") .. "",
      roleId = DB:GetData("playerId"),
      systemId = "1",
      platId = fif(accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ, "1", "2"),
      regionId = "1",
      userName = DB:GetData("fci/baseinfo/").name,
      areaId = DB:GetData("worldId") .. ""
    }
    local paramsJson = rapidjson.encode(params)
    local screenOffsetPix, topOffsetPix = PU.GetScreenOffsetPix(115)
    CS.NativeInterface.External_XYShowView(paramsJson, 0, topOffsetPix + screenOffsetPix, 0, screenOffsetPix)
  else
    CS.NativeInterface.External_XYCloseView()
  end
end

function PU.ShowXYTips(text)
  CS.NativeInterface.External_XYShowTips(text)
end

function PU.GetChannelId(channelName)
  local channelId = ""
  local channelsInfo = DB:GetData("ChannelsInfo")
  for i = 1, #channelsInfo do
    if channelName == channelsInfo[i].name then
      channelId = channelsInfo[i].id
      break
    end
  end
  return channelId
end

function PU.IsPrivilegeIgnore(channelId)
  local channelsInfo = DB:GetData("ChannelsInfo")
  local isIgnore = false
  for i = 1, #channelsInfo do
    if channelId == channelsInfo[i].id then
      isIgnore = channelsInfo[i].privilegeIgnore
      break
    end
  end
  return isIgnore
end

return PU
