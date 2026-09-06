local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBuyReturnGift = dataclass("SBuyReturnGift", require("framework.net.protocol"))
SBuyReturnGift.ProtocolType = 3647
SBuyReturnGift.MaxSize = 65535
SBuyReturnGift.giftID = 0
SBuyReturnGift.result = 0

function SBuyReturnGift:Ctor(client)
  SBuyReturnGift.super.Ctor(self, client)
end

function SBuyReturnGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.giftID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SBuyReturnGift:Unmarshal(buffer)
  local ret = true
  ret, self.giftID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBuyReturnGift
