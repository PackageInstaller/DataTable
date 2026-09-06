local NetManager = CS.PixelNeko.NetManager
local LuaManager = CS.PixelNeko.LuaManager
local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Client = CS.PixelNeko.Net.TCP.Client
local Protocols = require("protocols.protocols")
local LuaTCPClient = class("LuaTCPClient")

function LuaTCPClient:Ctor(id, hostname, port, username, token, plat, info)
  self._id = id
  self._loginState = false
  self._userid = 0
  self._token = ""
  LogInfoFormat("LuaTCPClient", "hostname = %s, port = %s, account = %s, token = %s, plat = %s", hostname, port, username, token, plat)
  if info then
    LogInfoFormat("LuaTCPClient", "sdkChannelId = %s", info.channelId)
  end
  self._client = NetManager.ConnectToServer(hostname, port, username, token, plat, info)
  self._time = 0
  self._heartBeatTime = 20
  self._exceptionString = ""
  self._offlineInfo = nil
end

function LuaTCPClient:OnSLogin(protocol)
  self._loginState = true
  self._userid = protocol.userid
  self._token = protocol.token
end

function LuaTCPClient:GetLoginState()
  return self._loginState
end

function LuaTCPClient:GetUserid()
  return self._userid
end

function LuaTCPClient:GetToken()
  return self._token
end

function LuaTCPClient:GetID()
  return self._id
end

function LuaTCPClient:GetHostname()
  return self._client:GetHostName()
end

function LuaTCPClient:GetPort()
  return self._client:GetPort()
end

function LuaTCPClient:GetUsername()
  return self._client:GetUsername()
end

function LuaTCPClient:Send(buffer)
  self._client:SendLuaProtocol(buffer)
end

function LuaTCPClient:Close()
  self._client:Close()
end

function LuaTCPClient:IsClosed()
  return self._client:IsServerClosed()
end

function LuaTCPClient:SetSHeartTime(time)
  self._client:SetSHeartTime(time)
end

function LuaTCPClient:StartHeart()
  self._client:StartHeart()
end

function LuaTCPClient:GetException()
  if self._exceptionString == "" and self._client then
    self._exceptionString = self._client:GetSocketExceptionMessage()
  end
  return self._exceptionString
end

function LuaTCPClient:GetOffLineInfo()
  if self._offlineInfo == nil and self._client then
    local offlineInfo = self._client:GetOfflineInfo()
    if offlineInfo.offtype ~= Client.initType then
      self._offlineInfo = offlineInfo
    end
  end
  return self._offlineInfo
end

function LuaTCPClient:CreateProtocol(protocolName)
  local protocol = require("protocols.def." .. protocolName).Create(self)
  return protocol
end

function LuaTCPClient:ProcessProtocols()
  if self._client then
    while true do
      local buffer = self._client:Pop()
      if not buffer then
        break
      end
      local ret, pType = true, 0
      ret, pType = ProtocolBufferStaticFunctions.ReadUInt32(buffer)
      if not ret then
        return ret
      end
      if not ret then
        LogError("LuaTCPClient", "unmarshal protocol type error!")
        return false
      end
      if not Protocols[pType] then
        LogErrorFormat("LuaTCPClient", "protocol not define! type = %s", pType)
        return false
      end
      local luafile = "protocols.def." .. Protocols[pType]
      if not _G[luafile] and not LuaManager.IsLuaFileExist(luafile) then
        LogErrorFormat("LuaTCPClient", "protocol file not found! luafile = %s", luafile)
        return false
      end
      local protocol = require(luafile).Create(self)
      ret = protocol:Unmarshal(buffer)
      if not ret then
        LogErrorFormat("LuaTCPClient", "protocol unmarshal error! type = %s", pType)
        return false
      end
      protocol:Process(self, LuaNetManager.GetMainConnect())
    end
  end
  return true
end

return LuaTCPClient
