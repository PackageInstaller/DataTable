local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShopDisplay = dataclass("SShopDisplay", require("framework.net.protocol"))
SShopDisplay.ProtocolType = 3648
SShopDisplay.MaxSize = 65535
SShopDisplay.shopType = 0
SShopDisplay.isMask = 0

function SShopDisplay:Ctor(client)
  SShopDisplay.super.Ctor(self, client)
end

function SShopDisplay:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.isMask) then
    return false
  end
  return true
end

function SShopDisplay:Unmarshal(buffer)
  local ret = true
  ret, self.shopType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isMask = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShopDisplay
