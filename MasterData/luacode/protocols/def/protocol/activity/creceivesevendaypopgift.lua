local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveSevenDayPopGift = dataclass("CReceiveSevenDayPopGift", require("framework.net.protocol"))
CReceiveSevenDayPopGift.ProtocolType = 2744
CReceiveSevenDayPopGift.MaxSize = 65535
CReceiveSevenDayPopGift.rewardId = 0

function CReceiveSevenDayPopGift:Ctor(client)
  CReceiveSevenDayPopGift.super.Ctor(self, client)
end

function CReceiveSevenDayPopGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardId) then
    return false
  end
  return true
end

function CReceiveSevenDayPopGift:Unmarshal(buffer)
  local ret = true
  ret, self.rewardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveSevenDayPopGift
