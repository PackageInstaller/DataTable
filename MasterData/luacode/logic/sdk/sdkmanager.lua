local PlatformManager = CS.PixelNeko.P1.PlatformManager
local Log = CS.PixelNeko.Log
local SdkManager = {}
local Agents = require("logic.sdk.agents")
local agent, _channel, _platform, _channelID, account
SdkManager.ReportType = {
  Register = 1,
  CreateRole = 2,
  Login = 3,
  Pay = 4,
  LevelUp = 5
}
local EventPointManager = CS.PixelNeko.P1.EventPoint.EventPointManager

local function Login(result)
  Log.LogInfo("luamain", "login callback")
  EventPointManager.TriggerEvent(EventPointManager.Test_SDKLoginSuccess, CS.PixelNeko.P1.EventPoint.EventPointPlatform.UMeng)
  local resultJson = JSON.decode(result)
  NekoData.DataManager.DM_Login:SetSDKLoginResult(resultJson)
  if resultJson.status and resultJson.status ~= "1" then
    NekoData.BehaviorManager.BM_Login:SDKLoginFail()
  else
    LuaNotificationCenter.PostNotification(Common.n_LoginResult, {}, result)
  end
end

local function Logout(result)
  Log.LogInfo("luamain", "logout callback")
  NekoData.DataManager.DM_Login:SetSDKLoginResult(nil)
  LuaNotificationCenter.PostNotification(Common.n_LogoutResult, {}, result)
  if LuaNetManager.GetMainConnect() then
    local resultJson = JSON.decode(result)
    if resultJson.status and resultJson.status == "1" then
      NekoData.BehaviorManager.BM_Login:SDKLogoutActive()
    end
  end
end

local function Quit(result)
  Log.LogInfo("luamain", "quit callback result:" .. result)
  CS.UnityEngine.Application.Quit()
end

local function DeepLink(result)
  Log.LogInfo("luamain", "DeepLink callback result:" .. result)
  LuaNotificationCenter.PostNotification(Common.n_OpenDeeplinkActivity, nil, nil)
end

local function Pay(result)
  Log.LogInfo("luamain", "Pay callback")
  local json = JSON.decode(result)
  if json.status then
    Log.LogInfo("luamain", " status:" .. json.status)
  end
end

function SdkManager.Init()
  Log.LogInfo("luamain", "SDKManager set SDK callback")
  PlatformManager.SetLoginCallback(Login)
  PlatformManager.SetLogoutCallback(Logout)
  PlatformManager.SetQuitCallback(Quit)
  PlatformManager.SetPayCallback(Pay)
  PlatformManager.SetDeepLinkCallback(DeepLink)
  _channel = PlatformManager.GetChannel()
  _platform = PlatformManager.GetPlatform()
  _channelID = PlatformManager.GetChannelID()
  print("channel", _channel)
  for _, v in ipairs(Agents) do
    if v.op(_channel) then
      agent = require(v.path)
      agent.Init()
      break
    end
  end
end

function SdkManager.GetChannel()
  return _channel
end

function SdkManager.GetPlatform()
  return _platform
end

function SdkManager.GetChannelID()
  local id = _channelID
  if (not id or id == "") and agent.GetChannelID then
    id = agent:GetChannelID()
  end
  return id
end

function SdkManager.GetAgent()
  return agent
end

function SdkManager.OpenLoginDialog()
  agent:OpenLoginDialog()
end

function SdkManager.SetSdkAccount(accountsr)
  account = accountsr
  agent:SetSDKAccount(accountsr)
end

function SdkManager.GetSdkAccount()
  return account
end

function SdkManager.Login(jsonstr)
  agent:Login(jsonstr)
end

function SdkManager.Logout(parmeter)
  agent:Logout(parmeter)
end

function SdkManager.Activate()
  if agent.Activate then
    agent:Activate()
  end
end

function SdkManager.Quit()
  agent:Quit()
end

function SdkManager.Pay(SResponseBuyDiamond)
  agent:Pay(SResponseBuyDiamond)
end

function SdkManager.Report(type, info)
  agent:Report(type, info)
end

function SdkManager.OpenAccountCenter()
  agent:OpenAccountCenter()
end

function SdkManager.SwitchAccount()
  agent:SwitchAccount()
end

function SdkManager.ShowPrivacy()
  agent:ShowPrivacy()
end

function SdkManager.GetPrice(price)
  return price
end

function SdkManager.UploadLog(...)
  return CS.PixelNeko.P1.Feedback.LogTrace.UploadFeedback("http://39.107.142.169:8866/api/feedback", ...)
end

function SdkManager:GetQuickChannelRecord(channelid)
  local record = BeanManager.GetTableByName("topup.cqudaomapping"):GetRecorder(channelid)
  if record then
    return record
  else
    LogErrorFormat("quick", "Can not find record by channelId: %s in Cqudaomapping", channelid)
  end
end

return SdkManager
