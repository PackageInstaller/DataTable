local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SHalloweenShopRedPoint = dataclass("SHalloweenShopRedPoint", require("framework.net.protocol"))
SHalloweenShopRedPoint.ProtocolType = 3645
SHalloweenShopRedPoint.MaxSize = 65535

function SHalloweenShopRedPoint:Ctor(client)
  SHalloweenShopRedPoint.super.Ctor(self, client)
end

function SHalloweenShopRedPoint:Marshal(buffer)
  return true
end

function SHalloweenShopRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SHalloweenShopRedPoint
