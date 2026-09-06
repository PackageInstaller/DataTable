local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBeforeDrawTenCard = dataclass("CBeforeDrawTenCard", require("framework.net.protocol"))
CBeforeDrawTenCard.ProtocolType = 1522
CBeforeDrawTenCard.MaxSize = 65535
CBeforeDrawTenCard.WaitProtocol = "protocol.notify.scancelloading"

function CBeforeDrawTenCard:Ctor(client)
  CBeforeDrawTenCard.super.Ctor(self, client)
end

function CBeforeDrawTenCard:Marshal(buffer)
  return true
end

function CBeforeDrawTenCard:Unmarshal(buffer)
  local ret = true
  return ret
end

return CBeforeDrawTenCard
