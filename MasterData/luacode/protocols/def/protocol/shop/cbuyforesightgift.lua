local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyForesightGift = dataclass("CBuyForesightGift", require("framework.net.protocol"))
CBuyForesightGift.ProtocolType = 3649
CBuyForesightGift.MaxSize = 65535
CBuyForesightGift.activityId = 0
CBuyForesightGift.goodId = 0

function CBuyForesightGift:Ctor(client)
  CBuyForesightGift.super.Ctor(self, client)
end

function CBuyForesightGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  return true
end

function CBuyForesightGift:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyForesightGift
