-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/net/tcpclient.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NetManager = (CS.PixelNeko).NetManager
local LuaManager = (CS.PixelNeko).LuaManager
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Client = (((CS.PixelNeko).Net).TCP).Client
local Protocols = require("protocols.protocols")
local LuaTCPClient = class("LuaTCPClient")
LuaTCPClient.Ctor = function(self, id, hostname, port, username, token, plat, info)
  -- function num : 0_0 , upvalues : _ENV, NetManager
  self._id = id
  self._loginState = false
  self._userid = 0
  self._token = ""
  LogInfoFormat("LuaTCPClient", "hostname = %s, port = %s, account = %s, token = %s, plat = %s", hostname, port, username, token, plat)
  if info then
    LogInfoFormat("LuaTCPClient", "sdkChannelId = %s", info.channelId)
  end
  self._client = (NetManager.ConnectToServer)(hostname, port, username, token, plat, info)
  self._time = 0
  self._heartBeatTime = 20
  self._exceptionString = ""
  self._offlineInfo = nil
end

LuaTCPClient.OnSLogin = function(self, protocol)
  -- function num : 0_1
  self._loginState = true
  self._userid = protocol.userid
  self._token = protocol.token
end

LuaTCPClient.GetLoginState = function(self)
  -- function num : 0_2
  return self._loginState
end

LuaTCPClient.GetUserid = function(self)
  -- function num : 0_3
  return self._userid
end

LuaTCPClient.GetToken = function(self)
  -- function num : 0_4
  return self._token
end

LuaTCPClient.GetID = function(self)
  -- function num : 0_5
  return self._id
end

LuaTCPClient.GetHostname = function(self)
  -- function num : 0_6
  return (self._client):GetHostName()
end

LuaTCPClient.GetPort = function(self)
  -- function num : 0_7
  return (self._client):GetPort()
end

LuaTCPClient.GetUsername = function(self)
  -- function num : 0_8
  return (self._client):GetUsername()
end

LuaTCPClient.Send = function(self, buffer)
  -- function num : 0_9
  (self._client):SendLuaProtocol(buffer)
end

LuaTCPClient.Close = function(self)
  -- function num : 0_10
  (self._client):Close()
end

LuaTCPClient.IsClosed = function(self)
  -- function num : 0_11
  return (self._client):IsServerClosed()
end

LuaTCPClient.SetSHeartTime = function(self, time)
  -- function num : 0_12
  (self._client):SetSHeartTime(time)
end

LuaTCPClient.StartHeart = function(self)
  -- function num : 0_13
  (self._client):StartHeart()
end

LuaTCPClient.GetException = function(self)
  -- function num : 0_14
  if self._exceptionString == "" and self._client then
    self._exceptionString = (self._client):GetSocketExceptionMessage()
  end
  return self._exceptionString
end

LuaTCPClient.GetOffLineInfo = function(self)
  -- function num : 0_15 , upvalues : Client
  do
    if self._offlineInfo == nil and self._client then
      local offlineInfo = (self._client):GetOfflineInfo()
      if offlineInfo.offtype ~= Client.initType then
        self._offlineInfo = offlineInfo
      end
    end
    return self._offlineInfo
  end
end

LuaTCPClient.CreateProtocol = function(self, protocolName)
  -- function num : 0_16 , upvalues : _ENV
  local protocol = ((require("protocols.def." .. protocolName)).Create)(self)
  return protocol
end

LuaTCPClient.ProcessProtocols = function(self)
  -- function num : 0_17 , upvalues : ProtocolBufferStaticFunctions, _ENV, Protocols, LuaManager
  while 1 do
    if self._client then
      local buffer = (self._client):Pop()
      if buffer then
        local ret, pType = true, 0
        ret = (ProtocolBufferStaticFunctions.ReadUInt32)(buffer)
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
        if not _G[luafile] and not (LuaManager.IsLuaFileExist)(luafile) then
          LogErrorFormat("LuaTCPClient", "protocol file not found! luafile = %s", luafile)
          return false
        end
        do
          local protocol = ((require(luafile)).Create)(self)
          ret = protocol:Unmarshal(buffer)
          if not ret then
            LogErrorFormat("LuaTCPClient", "protocol unmarshal error! type = %s", pType)
            return false
          end
          protocol:Process(self, (LuaNetManager.GetMainConnect)())
          -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return true
end

return LuaTCPClient

