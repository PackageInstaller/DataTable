local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CNewDrawCard = dataclass("CNewDrawCard", require("framework.net.protocol"))
CNewDrawCard.ProtocolType = 1505
CNewDrawCard.MaxSize = 65535
CNewDrawCard.WaitProtocol = "protocol.notify.scancelloading"

function CNewDrawCard:Ctor(client)
  CNewDrawCard.super.Ctor(self, client)
end

function CNewDrawCard:Marshal(buffer)
  return true
end

function CNewDrawCard:Unmarshal(buffer)
  local ret = true
  return ret
end

return CNewDrawCard
