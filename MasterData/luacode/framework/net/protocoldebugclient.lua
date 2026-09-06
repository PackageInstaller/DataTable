local NetManager = CS.PixelNeko.NetManager
local Protocols = require("protocols.protocols")
local json = require("framework.json")
local ProtocolDebugClient = class("ProtocolDebugClient")
local _filterIDs = {}

function ProtocolDebugClient:Ctor(hostname, port)
  self._host = hostname
  self._port = port
  self._dbgClient = NetManager.ConnectToDbgServer(hostname, port)
  if self._dbgClient then
    self._debugOn = true
  end
end

function ProtocolDebugClient:Close()
  if self._dbgClient then
    self._dbgClient:Close()
    self._dbgClient = nil
  end
end

function ProtocolDebugClient:DebugOn()
  local serverClosed = false
  if self._dbgClient then
    serverClosed = self._dbgClient:IsProtoDebugServerClosed()
  end
  return self._debugOn and not serverClosed
end

function ProtocolDebugClient:DebugSwitch(can)
  self._debugOn = can
end

function ProtocolDebugClient:SendMessage(protocol)
  if self._dbgClient:IsProtoDebugServerClosed() then
    return false
  end
  if protocol.ToJson == nil or type(protocol.ToJson) ~= "function" then
    warn("[ProtoDBG]", "this proto has no method: ToJson" .. protocol.ProtocolType, protocol.ToJson)
    return false
  end
  local msg = protocol:ToJson()
  self._dbgClient:SendDebugProto(msg)
  return true
end

function ProtocolDebugClient:IsCaptured(type)
  return false
end

function ProtocolDebugClient:ProcessDebugProtocol()
  if self._dbgClient then
    while true do
      local msg = self._dbgClient:Pop()
      if not msg then
        break
      end
      self:HandleDbgMsg(msg)
    end
  end
  return true
end

function ProtocolDebugClient:HandleDbgMsg(msg)
  if string.len(msg) == 0 then
    return
  end
  warn(">>> recv msg: ", msg)
  if not msg or string.len(msg) < 2 then
    warn(">> wrong json str: ", msg)
    return
  end
  if string.find(msg, "#FILTER#") then
    return
  end
  local jsonObj = json.decode(msg)
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
    local cmd = LuaNetManager.CreateProtocol(proto)
    cmd:ParseFromJson(jsonObj)
    cmd:Send(true)
  end
end

return ProtocolDebugClient
