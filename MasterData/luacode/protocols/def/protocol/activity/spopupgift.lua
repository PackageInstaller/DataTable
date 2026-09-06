local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPopUpGift = dataclass("SPopUpGift", require("framework.net.protocol"))
SPopUpGift.ProtocolType = 2691
SPopUpGift.MaxSize = 65535
SPopUpGift.activityID = 0
SPopUpGift.leftTime = 0
SPopUpGift.goodsId = 0
SPopUpGift.moneyType = 0
SPopUpGift.price = 0

function SPopUpGift:Ctor(client)
  SPopUpGift.super.Ctor(self, client)
end

function SPopUpGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodsId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.moneyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.price) then
    return false
  end
  return true
end

function SPopUpGift:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.goodsId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.moneyType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.price = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SPopUpGift
