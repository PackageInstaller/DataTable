-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_login.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Login = class("BM_Login")
local TCPClient = require("framework.net.tcpclient")
local _id = 0
local OfflineType = (LuaNetManager.GetBeanDef)("protocol.common.offlinetype")
BM_Login.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).login
  self._dm = (NekoData.DataManager).DM_Login
end

BM_Login.Login = function(self, username, passwd, hostname, port)
  -- function num : 0_1 , upvalues : _id, TCPClient
  local client = (self._dm):GetMainClient()
  if client then
    client:Close()
  end
  _id = _id + 1
  local client = (TCPClient.Create)(_id, hostname, port)
  ;
  (self._dm):SetMainClient(_id, client)
  local clogin = self:CreateProtocol("protocol.login.clogin")
  clogin.account = username
  clogin:Send()
  ;
  (self._dm):SetLoginInfo(username, passwd, hostname, port)
  return _id
end

BM_Login.CloseMainClient = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local client = (self._dm):GetMainClient()
  do
    if client then
      local id = client:GetID()
      client:Close()
      ;
      (self._dm):SetMainClient(0, nil)
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_MainConnectClosed, LuaNetManager, nil)
  end
end

BM_Login.CreateProtocol = function(self, name)
  -- function num : 0_3
  local client = (self._dm):GetMainClient()
  if client and name and name ~= "" then
    return client:CreateProtocol(name)
  end
end

BM_Login.CreateBean = function(self, name)
  -- function num : 0_4 , upvalues : _ENV
  return ((require("protocols.bean." .. beanName)).Create)()
end

BM_Login.Update = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local deletes = {}
  local main = (self._dm):GetMainClient()
  for id,client in pairs((self._dm):GetClients()) do
    client:UpdateHeartBeat(unscaledDeltaTime)
    client:ProcessProtocols()
    if client:IsClosed() then
      deletes[#deletes + 1] = id
      local exceptionString = client:GetException()
      if exceptionString ~= "" then
        if main and main:GetID() == client:GetID() then
          (LuaNotificationCenter.PostNotification)(Common.n_MainConnectException, LuaNetManager, client)
        end
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_ConnectException, LuaNetManager, client)
      end
      if main and main:GetID() == client:GetID() then
        (self._dm):SetMainClient(0, nil)
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_MainConnectClosed, LuaNetManager, client)
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_ConnectClosed, LuaNetManager, client)
    end
  end
  for i = 1, #deletes do
    (self._dm):RemoveClient(deletes[i])
  end
end

BM_Login.GetSDKLoginResult = function(self)
  -- function num : 0_6
  return (self._data).sdkLoginResult
end

BM_Login.ReturnLoginDialog = function(self)
  -- function num : 0_7 , upvalues : _ENV
  GlobalGameFSM:SetString("toLogin", "BreakOrReconnection")
end

BM_Login.SendCOffline = function(self)
  -- function num : 0_8 , upvalues : _ENV, OfflineType
  LogInfo("BM_Login", "SendCOffline")
  local coffline = (LuaNetManager.CreateProtocol)("protocol.common.coffline")
  if coffline then
    coffline.offtype = OfflineType.LOG_OFF
    coffline:Send()
  end
  ;
  (LuaNetManager.Close)()
end

BM_Login.SDKLoginFail = function(self)
  -- function num : 0_9 , upvalues : _ENV
  LogInfo("BM_Login", "SDKLoginFail")
  self:ReturnLoginDialog()
end

BM_Login.ClientLogout = function(self)
  -- function num : 0_10 , upvalues : _ENV
  LogInfo("BM_Login", "ClientLogout")
  self:SendCOffline()
  self:ReturnLoginDialog()
end

BM_Login.SDKLogoutActive = function(self)
  -- function num : 0_11 , upvalues : _ENV
  LogInfo("BM_Login", "SDKLogoutActive")
  self:SendCOffline()
  ;
  ((DialogManager.CreateSingletonDialog)("login.disconnectdialog")):Init(100194, {DataCommon.SDKLogoutActive}, function()
    -- function num : 0_11_0 , upvalues : self
    self:ReturnLoginDialog()
  end
)
end

BM_Login.SDKLogoutActiveAfterQuestIpSuccess = function(self)
  -- function num : 0_12 , upvalues : _ENV
  LogInfo("BM_Login", "SDKLogoutActiveAfterQuestIpSuccess")
  ;
  ((DialogManager.CreateSingletonDialog)("login.disconnectdialog")):Init(100194, {DataCommon.SDKLogoutActive}, function()
    -- function num : 0_12_0 , upvalues : self
    self:ReturnLoginDialog()
  end
)
end

BM_Login.IPServerLinkFail = function(self, jsonResult)
  -- function num : 0_13 , upvalues : _ENV
  LogInfo("BM_Login", "IPServerLinkFail")
  local msgId = 100425
  if jsonResult then
    if jsonResult == 3 then
      msgId = 100166
    else
      if jsonResult == 4 or jsonResult == 5 then
        msgId = 100021
      else
        if jsonResult == 7 then
          msgId = 100200
        else
          if jsonResult == 8 then
            msgId = 100497
          end
        end
      end
    end
  end
  ;
  ((DialogManager.CreateSingletonDialog)("login.disconnectdialog")):Init(msgId, {tostring(DataCommon.IPServerLinkFail) .. "_" .. tostring(jsonResult)}, function()
    -- function num : 0_13_0 , upvalues : self
    self:ReturnLoginDialog()
  end
)
end

BM_Login.CancleLoginQueue = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (LuaNetManager.Close)()
  self:ReturnLoginDialog()
end

BM_Login.GetForbidLoginRestTime = function(self)
  -- function num : 0_15
  if (self._data).forbidLoginRestTime then
    return (self._data).forbidLoginRestTime // 1000
  end
end

BM_Login.SetLoginFailTimes = function(self, num)
  -- function num : 0_16
  (self._dm):SetLoginFailTimes(num)
end

BM_Login.GetLoginFailTimes = function(self)
  -- function num : 0_17
  return (self._data).loginFailTimes
end

BM_Login.GetCBattleEndInfo = function(self)
  -- function num : 0_18
  return (self._data).cbattleEndProtocol
end

BM_Login.GetCBattleEndType = function(self)
  -- function num : 0_19
  return (self._data).battleEndType
end

BM_Login.GetSBattleStartInfo = function(self)
  -- function num : 0_20
  return (self._data).sbattleStartProtocol
end

BM_Login.IfCanUseLocalCBattleEnd = function(self, sbattlestart)
  -- function num : 0_21 , upvalues : _ENV
  if (self._data).cbattleEndProtocol and (self._data).sbattleStartProtocol then
    LogInfoFormat("BM_Login", "sbattlestart.battleVerifyNum %s localsbattlestart.battleVerifyNum %s", sbattlestart.battleVerifyNum, ((self._data).sbattleStartProtocol).battleVerifyNum)
    if sbattlestart.battleid == ((self._data).sbattleStartProtocol).battleid and sbattlestart.battleVerifyNum == ((self._data).sbattleStartProtocol).battleVerifyNum + 1 then
      return true
    else
      LogError("BM_Login", "IfCanUseLocalCBattleEnd failed")
    end
  end
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).cbattleEndProtocol = nil
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).battleEndType = nil
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).sbattleStartProtocol = nil
  return false
end

BM_Login.GetAccount = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local resultJson = self:GetSDKLoginResult()
  local channel = (SdkManager.GetChannel)()
  if channel == "none" then
    return resultJson.account
  else
    if channel == "leit" then
      return resultJson.userId
    else
      if channel == "qian" then
        return resultJson.userId
      else
        if channel == "mqan" then
          return resultJson.userId
        end
      end
    end
  end
end

BM_Login.SetGameOpenFromDeepLinkTag = function(self)
  -- function num : 0_23 , upvalues : _ENV
  if (((CS.PixelNeko).P1).DeepLink).GetDeepLinkJsonString then
    ((((CS.PixelNeko).P1).DeepLink).GetDeepLinkJsonString)()
  end
  if (((CS.PixelNeko).P1).DeepLink).GetInfo then
    local deeplinkStr = ((((CS.PixelNeko).P1).DeepLink).GetInfo)()
    LogInfoFormat("BM_Login", "deeplinkStr %s", deeplinkStr)
    if deeplinkStr and deeplinkStr ~= "" then
      LogInfoFormat("BM_Login", " SetGameOpenFromDeepLinkTag is true")
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._data).gameOpenFromDeepLink = true
    end
  end
end

BM_Login.GetGameOpenFromDeepLinkTag = function(self)
  -- function num : 0_24
  return (self._data).gameOpenFromDeepLink
end

BM_Login.ClearGameOpenFromDeepLinkTag = function(self)
  -- function num : 0_25
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).gameOpenFromDeepLink = false
end

return BM_Login

