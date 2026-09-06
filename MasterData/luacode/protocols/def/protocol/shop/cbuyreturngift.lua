local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyReturnGift = dataclass("CBuyReturnGift", require("framework.net.protocol"))
CBuyReturnGift.ProtocolType = 3646
CBuyReturnGift.MaxSize = 65535
CBuyReturnGift.giftID = 0
CBuyReturnGift.giftType = 0
CBuyReturnGift.INVITATE = 1
CBuyReturnGift.RETURN = 2

function CBuyReturnGift:Ctor(client)
  CBuyReturnGift.super.Ctor(self, client)
end

function CBuyReturnGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.giftID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.giftType) then
    return false
  end
  return true
end

function CBuyReturnGift:Unmarshal(buffer)
  local ret = true
  ret, self.giftID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.giftType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyReturnGift
