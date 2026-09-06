local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendFlowers = dataclass("SSendFlowers", require("framework.net.protocol"))
SSendFlowers.ProtocolType = 2601
SSendFlowers.MaxSize = 65535
SSendFlowers.rewardType = 0
SSendFlowers.flowerScore = 0

function SSendFlowers:Ctor(client)
  SSendFlowers.super.Ctor(self, client)
end

function SSendFlowers:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.flowerScore) then
    return false
  end
  return true
end

function SSendFlowers:Unmarshal(buffer)
  local ret = true
  ret, self.rewardType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.flowerScore = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendFlowers
