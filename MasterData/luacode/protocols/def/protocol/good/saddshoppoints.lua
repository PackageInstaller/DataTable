local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddShopPoints = dataclass("SAddShopPoints", require("framework.net.protocol"))
SAddShopPoints.ProtocolType = 3410
SAddShopPoints.MaxSize = 65535
SAddShopPoints.addScore = 0

function SAddShopPoints:Ctor(client)
  SAddShopPoints.super.Ctor(self, client)
end

function SAddShopPoints:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.addScore) then
    return false
  end
  return true
end

function SAddShopPoints:Unmarshal(buffer)
  local ret = true
  ret, self.addScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddShopPoints
