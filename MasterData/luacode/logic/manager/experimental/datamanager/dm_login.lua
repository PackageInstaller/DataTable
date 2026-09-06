local DM_Login = class("DM_Login")

function DM_Login:Ctor()
  self._data = NekoData.Data.login
  self._data.username = nil
  self._data.passwd = nil
  self._data.token = nil
  self._data.hostname = nil
  self._data.port = nil
  self._data.status = nil
  self._data.channelInfo = nil
  self._data.clients = {}
  self._data.mainID = 0
  self._data.sdkLoginResult = nil
  self._data.forbidLoginRestTime = 0
  self._data.loginFailTimes = 0
  self._data.cbattleEndProtocol = nil
  self._data.battleEndType = nil
  self._data.sbattleStartProtocol = nil
end

function DM_Login:Clear()
  self._data.username = nil
  self._data.passwd = nil
  self._data.token = nil
  self._data.hostname = nil
  self._data.port = nil
  self._data.status = nil
  self._data.channelInfo = nil
  for k, v in pairs(self._data.clients) do
    self._data.clients[k] = nil
  end
  self._data.mainID = 0
  self._data.forbidLoginRestTime = 0
  self._data.loginFailTimes = 0
end

function DM_Login:SetLoginInfo(username, passwd, hostname, port)
  self._data.username = username
  self._data.passwd = passwd
  self._data.hostname = hostname
  self._data.port = port
end

function DM_Login:RemoveClient(id)
  self._data.clients[id] = nil
end

function DM_Login:SetMainClient(id, client)
  self._data.clients[id] = client
  self._data.mainID = id
end

function DM_Login:GetMainClient()
  return self._data.clients[self._data.mainID]
end

function DM_Login:SetSDKLoginResult(result)
  self._data.sdkLoginResult = result
end

function DM_Login:SetForbidLoginRestTime(restTime)
  self._data.forbidLoginRestTime = restTime
end

function DM_Login:SetLoginFailTimes(num)
  self._data.loginFailTimes = num
end

function DM_Login:SetCBattleEndInfo(protocol, battleEndType, sbattlestart)
  self._data.cbattleEndProtocol = protocol
  self._data.battleEndType = battleEndType
  self._data.sbattleStartProtocol = sbattlestart
end

return DM_Login
