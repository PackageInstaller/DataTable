local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUnlockHigh = dataclass("CUnlockHigh", require("framework.net.protocol"))
CUnlockHigh.ProtocolType = 2403
CUnlockHigh.MaxSize = 65535
CUnlockHigh.WaitProtocol = "protocol.notify.scancelloading"

function CUnlockHigh:Ctor(client)
  CUnlockHigh.super.Ctor(self, client)
end

function CUnlockHigh:Marshal(buffer)
  return true
end

function CUnlockHigh:Unmarshal(buffer)
  local ret = true
  return ret
end

return CUnlockHigh
