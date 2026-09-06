local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUpdateEchoEvent = dataclass("CUpdateEchoEvent", require("framework.net.protocol"))
CUpdateEchoEvent.ProtocolType = 2712
CUpdateEchoEvent.MaxSize = 65536

function CUpdateEchoEvent:Ctor(client)
  CUpdateEchoEvent.super.Ctor(self, client)
end

function CUpdateEchoEvent:Marshal(buffer)
  return true
end

function CUpdateEchoEvent:Unmarshal(buffer)
  local ret = true
  return ret
end

return CUpdateEchoEvent
