local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShowRewardProgress = dataclass("SShowRewardProgress", require("framework.net.protocol"))
SShowRewardProgress.ProtocolType = 4114
SShowRewardProgress.MaxSize = 65535
SShowRewardProgress.totalPithy = 0
SShowRewardProgress.maxContinueId = 0

function SShowRewardProgress:Ctor(client)
  SShowRewardProgress.super.Ctor(self, client)
  self.rewardList = {}
end

function SShowRewardProgress:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.totalPithy) then
    return false
  end
  local length = table.slen(self.rewardList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardList[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.maxContinueId) then
    return false
  end
  return true
end

function SShowRewardProgress:Unmarshal(buffer)
  local ret = true
  ret, self.totalPithy = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.rewardList[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.maxContinueId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShowRewardProgress
