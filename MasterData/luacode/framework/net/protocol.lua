local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local LuaManager = CS.PixelNeko.LuaManager
local ProtocolBuffer = CS.PixelNeko.Net.ProtocolBuffer
local Protocols = require("protocols.protocols")
local Protocol = class("Protocol")

function Protocol:Ctor(mainClient)
  self._mainClient = mainClient
end

function Protocol:Send(pass)
  if not pass and LuaNetManager.MonitorProtoSend(self) then
    return
  end
  if self.WaitProtocol and not NekoData.BehaviorManager.BM_Game:CanSendResponseWaitProtocol(self.ProtocolType, self.WaitProtocol) then
    return
  end
  local buffer = ProtocolBuffer.Create()
  ProtocolBufferStaticFunctions.WriteUInt32(buffer, self.ProtocolType)
  self:Marshal(buffer)
  LogInfoFormat("Protocol", "send protocol: %s", Protocols[self.ProtocolType])
  if not self._mainClient then
    LogInfoFormat("Protocol", "self._mainClient is nil when sending the protocol.")
  else
    if self.WaitProtocol then
      local waitProtocolDef = require("protocols.def." .. self.WaitProtocol)
      if not waitProtocolDef then
        LogErrorFormat("Protocol", "waitProtocolDef can not found! waitprotocol = %s", self.WaitProtocol)
      else
        LogInfoFormat("Protocol", "-- protocolType = %s, waitProtocolName = %s --", self.ProtocolType, self.WaitProtocol)
        NekoData.BehaviorManager.BM_Game:OpenResponseWaitDialog(self.ProtocolType, self.WaitProtocol)
      end
    end
    self._mainClient:Send(buffer)
  end
end

function Protocol:Process(client, mainclient)
  local luafile = "logic.protocolhandler." .. Protocols[self.ProtocolType]
  if not _G[luafile] and not LuaManager.IsLuaFileExist(luafile) then
    LogErrorFormat("Protocol", "protocolhandler file not found! luafile = %s", luafile)
    return
  end
  NekoData.BehaviorManager.BM_Game:CloseResponseWaitDialog(self)
  local ProcessHandler = require(luafile)
  if client == mainclient then
    LogInfoFormat("Protocol", "process protocol 1: %s", Protocols[self.ProtocolType])
    ProcessHandler[1](self)
  else
    LogInfoFormat("Protocol", "process protocol 2: %s", Protocols[self.ProtocolType])
    ProcessHandler[2](self, client)
  end
end

return Protocol
