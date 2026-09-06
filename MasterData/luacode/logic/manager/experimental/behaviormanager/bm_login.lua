local BM_Login = class("BM_Login")
local TCPClient = require("framework.net.tcpclient")
local _id = 0
local OfflineType = LuaNetManager.GetBeanDef("protocol.common.offlinetype")

function BM_Login:Ctor()
  self._data = NekoData.Data.login
  self._dm = NekoData.DataManager.DM_Login
end

function BM_Login:Login(username, passwd, hostname, port)
  local client = self._dm:GetMainClient()
  if client then
    client:Close()
  end
  _id = _id + 1
  local client = TCPClient.Create(_id, hostname, port)
  self._dm:SetMainClient(_id, client)
  local clogin = self:CreateProtocol("protocol.login.clogin")
  clogin.account = username
  clogin:Send()
  self._dm:SetLoginInfo(username, passwd, hostname, port)
  return _id
end

function BM_Login:CloseMainClient()
  local client = self._dm:GetMainClient()
  if client then
    local id = client:GetID()
    client:Close()
    self._dm:SetMainClient(0, nil)
  end
  LuaNotificationCenter.PostNotification(Common.n_MainConnectClosed, LuaNetManager, nil)
end

function BM_Login:CreateProtocol(name)
  local client = self._dm:GetMainClient()
  if client and name and name ~= "" then
    return client:CreateProtocol(name)
  end
end

function BM_Login:CreateBean(name)
  return require("protocols.bean." .. beanName).Create()
end

function BM_Login:Update()
  local deletes = {}
  local main = self._dm:GetMainClient()
  for id, client in pairs(self._dm:GetClients()) do
    client:UpdateHeartBeat(unscaledDeltaTime)
    client:ProcessProtocols()
    if client:IsClosed() then
      deletes[#deletes + 1] = id
      local exceptionString = client:GetException()
      if exceptionString ~= "" then
        if main and main:GetID() == client:GetID() then
          LuaNotificationCenter.PostNotification(Common.n_MainConnectException, LuaNetManager, client)
        end
        LuaNotificationCenter.PostNotification(Common.n_ConnectException, LuaNetManager, client)
      end
      if main and main:GetID() == client:GetID() then
        self._dm:SetMainClient(0, nil)
        LuaNotificationCenter.PostNotification(Common.n_MainConnectClosed, LuaNetManager, client)
      end
      LuaNotificationCenter.PostNotification(Common.n_ConnectClosed, LuaNetManager, client)
    end
  end
  for i = 1, #deletes do
    self._dm:RemoveClient(deletes[i])
  end
end

function BM_Login:GetSDKLoginResult()
  return self._data.sdkLoginResult
end

function BM_Login:ReturnLoginDialog()
  GlobalGameFSM:SetString("toLogin", "BreakOrReconnection")
end

function BM_Login:SendCOffline()
  LogInfo("BM_Login", "SendCOffline")
  local coffline = LuaNetManager.CreateProtocol("protocol.common.coffline")
  if coffline then
    coffline.offtype = OfflineType.LOG_OFF
    coffline:Send()
  end
  LuaNetManager.Close()
end

function BM_Login:SDKLoginFail()
  LogInfo("BM_Login", "SDKLoginFail")
  self:ReturnLoginDialog()
end

function BM_Login:ClientLogout()
  LogInfo("BM_Login", "ClientLogout")
  self:SendCOffline()
  if SdkManager.GetChannel() == "quka" or SdkManager.GetChannel() == "qukb" then
    SdkManager.Logout()
  end
  self:ReturnLoginDialog()
end

function BM_Login:SDKLogoutActive()
  LogInfo("BM_Login", "SDKLogoutActive")
  self:SendCOffline()
  DialogManager.CreateSingletonDialog("login.disconnectdialog"):Init(100194, {
    DataCommon.SDKLogoutActive
  }, function()
    self:ReturnLoginDialog()
  end)
end

function BM_Login:SDKLogoutActiveAfterQuestIpSuccess()
  LogInfo("BM_Login", "SDKLogoutActiveAfterQuestIpSuccess")
  DialogManager.CreateSingletonDialog("login.disconnectdialog"):Init(100194, {
    DataCommon.SDKLogoutActive
  }, function()
    self:ReturnLoginDialog()
  end)
end

function BM_Login:IPServerLinkFail(jsonResult)
  LogInfo("BM_Login", "IPServerLinkFail")
  local msgId = 100425
  if jsonResult then
    if jsonResult == 3 then
      msgId = 100166
    elseif jsonResult == 4 or jsonResult == 5 then
      msgId = 100021
    elseif jsonResult == 7 then
      msgId = 100200
    elseif jsonResult == 8 then
      msgId = 100497
    end
  end
  DialogManager.CreateSingletonDialog("login.disconnectdialog"):Init(msgId, {
    tostring(DataCommon.IPServerLinkFail) .. "_" .. tostring(jsonResult)
  }, function()
    self:ReturnLoginDialog()
  end)
end

function BM_Login:CancleLoginQueue()
  LuaNetManager.Close()
  self:ReturnLoginDialog()
end

function BM_Login:GetForbidLoginRestTime()
  return self._data.forbidLoginRestTime and self._data.forbidLoginRestTime // 1000
end

function BM_Login:SetLoginFailTimes(num)
  self._dm:SetLoginFailTimes(num)
end

function BM_Login:GetLoginFailTimes()
  return self._data.loginFailTimes
end

function BM_Login:GetCBattleEndInfo()
  return self._data.cbattleEndProtocol
end

function BM_Login:GetCBattleEndType()
  return self._data.battleEndType
end

function BM_Login:GetSBattleStartInfo()
  return self._data.sbattleStartProtocol
end

function BM_Login:IfCanUseLocalCBattleEnd(sbattlestart)
  if self._data.cbattleEndProtocol and self._data.sbattleStartProtocol then
    LogInfoFormat("BM_Login", "sbattlestart.battleVerifyNum %s localsbattlestart.battleVerifyNum %s", sbattlestart.battleVerifyNum, self._data.sbattleStartProtocol.battleVerifyNum)
    if sbattlestart.battleid == self._data.sbattleStartProtocol.battleid and sbattlestart.battleVerifyNum == self._data.sbattleStartProtocol.battleVerifyNum + 1 then
      return true
    else
      LogError("BM_Login", "IfCanUseLocalCBattleEnd failed")
    end
  end
  self._data.cbattleEndProtocol = nil
  self._data.battleEndType = nil
  self._data.sbattleStartProtocol = nil
  return false
end

function BM_Login:GetAccount()
  local resultJson = self:GetSDKLoginResult()
  local channel = SdkManager.GetChannel()
  if channel == "none" then
    return resultJson.account
  elseif channel == "leit" then
    return resultJson.userId
  elseif channel == "qian" then
    return resultJson.userId
  elseif channel == "mqan" then
    return resultJson.userId
  elseif channel == "quka" then
    return resultJson.userId
  elseif channel == "qukb" then
    return resultJson.userId
  end
end

return BM_Login
