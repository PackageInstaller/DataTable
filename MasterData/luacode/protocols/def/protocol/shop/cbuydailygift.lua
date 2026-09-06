local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyDailyGift = dataclass("CBuyDailyGift", require("framework.net.protocol"))
CBuyDailyGift.ProtocolType = 3627
CBuyDailyGift.MaxSize = 65535
CBuyDailyGift.giftID = 0

function CBuyDailyGift:Ctor(client)
  CBuyDailyGift.super.Ctor(self, client)
end

function CBuyDailyGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.giftID) then
    return false
  end
  return true
end

function CBuyDailyGift:Unmarshal(buffer)
  local ret = true
  ret, self.giftID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyDailyGift
