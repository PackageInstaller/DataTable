local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBuyDiamondGood = dataclass("SBuyDiamondGood", require("framework.net.protocol"))
SBuyDiamondGood.ProtocolType = 3618
SBuyDiamondGood.MaxSize = 65535
SBuyDiamondGood.result = 0
SBuyDiamondGood.shopId = 0

function SBuyDiamondGood:Ctor(client)
  SBuyDiamondGood.super.Ctor(self, client)
  self.refresh = require("protocols.bean.protocol.shop.mixgoodinfo").Create()
end

function SBuyDiamondGood:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopId) then
    return false
  end
  if not self.refresh:Marshal(buffer) then
    return false
  end
  return true
end

function SBuyDiamondGood:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.shopId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.refresh:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SBuyDiamondGood
