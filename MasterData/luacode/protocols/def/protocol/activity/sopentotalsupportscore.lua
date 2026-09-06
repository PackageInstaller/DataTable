local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenTotalSupportScore = dataclass("SOpenTotalSupportScore", require("framework.net.protocol"))
SOpenTotalSupportScore.ProtocolType = 2569
SOpenTotalSupportScore.MaxSize = 65535
SOpenTotalSupportScore.score = 0

function SOpenTotalSupportScore:Ctor(client)
  SOpenTotalSupportScore.super.Ctor(self, client)
  self.rewardIds = {}
end

function SOpenTotalSupportScore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.score) then
    return false
  end
  local length = table.slen(self.rewardIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardIds[i]) then
      return false
    end
  end
  return true
end

function SOpenTotalSupportScore:Unmarshal(buffer)
  local ret = true
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.rewardIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SOpenTotalSupportScore
