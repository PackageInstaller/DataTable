local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenYard = dataclass("COpenYard", require("framework.net.protocol"))
COpenYard.ProtocolType = 2349
COpenYard.MaxSize = 65535
COpenYard.WaitProtocol = "protocol.notify.scancelloading"

function COpenYard:Ctor(client)
  COpenYard.super.Ctor(self, client)
end

function COpenYard:Marshal(buffer)
  return true
end

function COpenYard:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenYard
