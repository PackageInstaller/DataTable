local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBeforeDrawCard = dataclass("SBeforeDrawCard", require("framework.net.protocol"))
SBeforeDrawCard.ProtocolType = 1523
SBeforeDrawCard.MaxSize = 65565
SBeforeDrawCard.drawTimes = 0
SBeforeDrawCard.baodiNum = 0
SBeforeDrawCard.share = 0

function SBeforeDrawCard:Ctor(client)
  SBeforeDrawCard.super.Ctor(self, client)
  self.roleList = {}
end

function SBeforeDrawCard:Marshal(buffer)
  local length = table.slen(self.roleList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleList[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.drawTimes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.baodiNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.share) then
    return false
  end
  return true
end

function SBeforeDrawCard:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.roleList[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.drawTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.baodiNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.share = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBeforeDrawCard
