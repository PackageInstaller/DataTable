local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShopPoints = dataclass("SShopPoints", require("framework.net.protocol"))
SShopPoints.ProtocolType = 3409
SShopPoints.MaxSize = 65535
SShopPoints.level = 0
SShopPoints.score = 0
SShopPoints.totalScore = 0

function SShopPoints:Ctor(client)
  SShopPoints.super.Ctor(self, client)
  self.reward = {}
end

function SShopPoints:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalScore) then
    return false
  end
  local length = table.slen(self.reward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.reward[i]) then
      return false
    end
  end
  return true
end

function SShopPoints:Unmarshal(buffer)
  local ret = true
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.reward[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SShopPoints
