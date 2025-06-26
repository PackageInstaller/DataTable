-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/net/protocoldebugclient.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NetManager = (CS.PixelNeko).NetManager
local Protocols = require("protocols.protocols")
local json = require("framework.json")
local ProtocolDebugClient = class("ProtocolDebugClient")
local _filterIDs = {}
ProtocolDebugClient.Ctor = function(self, hostname, port)
  -- function num : 0_0 , upvalues : NetManager
  self._host = hostname
  self._port = port
  self._dbgClient = (NetManager.ConnectToDbgServer)(hostname, port)
  if self._dbgClient then
    self._debugOn = true
  end
end

ProtocolDebugClient.Close = function(self)
  -- function num : 0_1
  if self._dbgClient then
    (self._dbgClient):Close()
    self._dbgClient = nil
  end
end

ProtocolDebugClient.DebugOn = function(self)
  -- function num : 0_2
  local serverClosed = false
  if self._dbgClient then
    serverClosed = (self._dbgClient):IsProtoDebugServerClosed()
  end
  if self._debugOn then
    return not serverClosed
  end
end

ProtocolDebugClient.DebugSwitch = function(self, can)
  -- function num : 0_3
  self._debugOn = can
end

ProtocolDebugClient.SendMessage = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  if (self._dbgClient):IsProtoDebugServerClosed() then
    return false
  end
  if protocol.ToJson == nil or type(protocol.ToJson) ~= "function" then
    warn("[ProtoDBG]", "this proto has no method: ToJson" .. protocol.ProtocolType, protocol.ToJson)
    return false
  end
  local msg = protocol:ToJson()
  ;
  (self._dbgClient):SendDebugProto(msg)
  return true
end

ProtocolDebugClient.IsCaptured = function(self, type)
  -- function num : 0_5
  return false
end

ProtocolDebugClient.ProcessDebugProtocol = function(self)
  -- function num : 0_6
  while 1 do
    if self._dbgClient then
      local msg = (self._dbgClient):Pop()
      if msg then
        do
          self:HandleDbgMsg(msg)
          -- DECOMPILER ERROR at PC11: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC11: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC11: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC11: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return true
end

ProtocolDebugClient.HandleDbgMsg = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, json, Protocols
  if (string.len)(msg) == 0 then
    return 
  end
  warn(">>> recv msg: ", msg)
  if not msg or (string.len)(msg) < 2 then
    warn(">> wrong json str: ", msg)
    return 
  end
  if (string.find)(msg, "#FILTER#") then
    return 
  end
  local jsonObj = (json.decode)(msg)
  if not jsonObj or type(jsonObj) ~= "table" then
    warn(">> decode json error", jsonObj)
    return 
  end
  local protoId = jsonObj.ProtocolType
  if protoId == nil then
    warn(">>> error proto")
    return 
  end
  local proto = Protocols[protoId]
  if proto then
    local cmd = (LuaNetManager.CreateProtocol)(proto)
    cmd:ParseFromJson(jsonObj)
    cmd:Send(true)
  end
end

return ProtocolDebugClient

