local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CShareDrawCard = dataclass("CShareDrawCard", require("framework.net.protocol"))
CShareDrawCard.ProtocolType = 1530
CShareDrawCard.MaxSize = 65535

function CShareDrawCard:Ctor(client)
  CShareDrawCard.super.Ctor(self, client)
end

function CShareDrawCard:Marshal(buffer)
  return true
end

function CShareDrawCard:Unmarshal(buffer)
  local ret = true
  return ret
end

return CShareDrawCard
