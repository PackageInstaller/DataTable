-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sdk/sdkmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PlatformManager = ((CS.PixelNeko).P1).PlatformManager
local Log = (CS.PixelNeko).Log
local SdkManager = {}
local Agents = (require("logic.sdk.agents"))
local agent, _channel, _platform, _channelID, account = nil, nil, nil, nil, nil
SdkManager.ReportType = {Register = 1, CreateRole = 2, Login = 3, Pay = 4, LevelUp = 5}
local EventPointManager = (((CS.PixelNeko).P1).EventPoint).EventPointManager
local Login = function(result)
  -- function num : 0_0 , upvalues : Log, EventPointManager, _ENV
  (Log.LogInfo)("luamain", "login callback")
  ;
  (EventPointManager.TriggerEvent)(EventPointManager.Test_SDKLoginSuccess, ((((CS.PixelNeko).P1).EventPoint).EventPointPlatform).UMeng)
  local resultJson = (JSON.decode)(result)
  ;
  ((NekoData.DataManager).DM_Login):SetSDKLoginResult(resultJson)
  if resultJson.status and resultJson.status ~= "1" then
    ((NekoData.BehaviorManager).BM_Login):SDKLoginFail()
  else
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_LoginResult, {}, result)
  end
end

local Logout = function(result)
  -- function num : 0_1 , upvalues : Log, _ENV
  (Log.LogInfo)("luamain", "logout callback")
  ;
  ((NekoData.DataManager).DM_Login):SetSDKLoginResult(nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_LogoutResult, {}, result)
  if (LuaNetManager.GetMainConnect)() then
    local resultJson = (JSON.decode)(result)
    if resultJson.status and resultJson.status == "1" then
      ((NekoData.BehaviorManager).BM_Login):SDKLogoutActive()
    end
  end
end

local Quit = function(result)
  -- function num : 0_2 , upvalues : Log, _ENV
  (Log.LogInfo)("luamain", "quit callback result:" .. result)
  ;
  (((CS.UnityEngine).Application).Quit)()
end

local DeepLink = function(result)
  -- function num : 0_3 , upvalues : Log
  (Log.LogInfo)("luamain", "DeepLink callback result:" .. result)
end

local Pay = function(result)
  -- function num : 0_4 , upvalues : Log, _ENV
  (Log.LogInfo)("luamain", "Pay callback")
  local json = (JSON.decode)(result)
  if json.status then
    (Log.LogInfo)("luamain", " status:" .. json.status)
  end
end

SdkManager.Init = function()
  -- function num : 0_5 , upvalues : Log, PlatformManager, Login, Logout, Quit, Pay, DeepLink, _channel, _platform, _channelID, _ENV, Agents, agent
  (Log.LogInfo)("luamain", "SDKManager set SDK callback")
  ;
  (PlatformManager.SetLoginCallback)(Login)
  ;
  (PlatformManager.SetLogoutCallback)(Logout)
  ;
  (PlatformManager.SetQuitCallback)(Quit)
  ;
  (PlatformManager.SetPayCallback)(Pay)
  ;
  (PlatformManager.SetDeepLinkCallback)(DeepLink)
  _channel = (PlatformManager.GetChannel)()
  _platform = (PlatformManager.GetPlatform)()
  _channelID = (PlatformManager.GetChannelID)()
  print("channel", _channel)
  for _,v in ipairs(Agents) do
    if (v.op)(_channel) then
      agent = require(v.path)
      ;
      (agent.Init)()
      break
    end
  end
end

SdkManager.GetChannel = function()
  -- function num : 0_6 , upvalues : _channel
  return _channel
end

SdkManager.GetPlatform = function()
  -- function num : 0_7 , upvalues : _platform
  return _platform
end

SdkManager.GetChannelID = function()
  -- function num : 0_8 , upvalues : _channelID, agent
  local id = _channelID
  if (not id or id == "") and agent.GetChannelID then
    id = agent:GetChannelID()
  end
  return id
end

SdkManager.GetAgent = function()
  -- function num : 0_9 , upvalues : agent
  return agent
end

SdkManager.OpenLoginDialog = function()
  -- function num : 0_10 , upvalues : agent
  agent:OpenLoginDialog()
end

SdkManager.SetSdkAccount = function(accountsr)
  -- function num : 0_11 , upvalues : account, agent
  account = accountsr
  agent:SetSDKAccount(accountsr)
end

SdkManager.GetSdkAccount = function()
  -- function num : 0_12 , upvalues : account
  return account
end

SdkManager.Login = function(jsonstr)
  -- function num : 0_13 , upvalues : agent
  agent:Login(jsonstr)
end

SdkManager.Logout = function(parmeter)
  -- function num : 0_14 , upvalues : agent
  agent:Logout(parmeter)
end

SdkManager.Activate = function()
  -- function num : 0_15 , upvalues : agent
  if agent.Activate then
    agent:Activate()
  end
end

SdkManager.Quit = function()
  -- function num : 0_16 , upvalues : agent
  agent:Quit()
end

SdkManager.Pay = function(SResponseBuyDiamond)
  -- function num : 0_17 , upvalues : agent
  agent:Pay(SResponseBuyDiamond)
end

SdkManager.Report = function(type, info)
  -- function num : 0_18 , upvalues : agent
  agent:Report(type, info)
end

SdkManager.OpenAccountCenter = function()
  -- function num : 0_19 , upvalues : agent
  agent:OpenAccountCenter()
end

SdkManager.SwitchAccount = function()
  -- function num : 0_20 , upvalues : agent
  agent:SwitchAccount()
end

SdkManager.ShowPrivacy = function()
  -- function num : 0_21 , upvalues : agent
  agent:ShowPrivacy()
end

SdkManager.GetPrice = function(price)
  -- function num : 0_22
  return price
end

SdkManager.UploadLog = function(...)
  -- function num : 0_23 , upvalues : _ENV
  return (((((CS.PixelNeko).P1).Feedback).LogTrace).UploadFeedback)("http://39.107.142.169:8866/api/feedback", ...)
end

return SdkManager

