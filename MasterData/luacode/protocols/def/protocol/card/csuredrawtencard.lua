local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSureDrawTenCard = dataclass("CSureDrawTenCard", require("framework.net.protocol"))
CSureDrawTenCard.ProtocolType = 1524
CSureDrawTenCard.MaxSize = 65535

function CSureDrawTenCard:Ctor(client)
  CSureDrawTenCard.super.Ctor(self, client)
end

function CSureDrawTenCard:Marshal(buffer)
  return true
end

function CSureDrawTenCard:Unmarshal(buffer)
  local ret = true
  return ret
end

return CSureDrawTenCard
