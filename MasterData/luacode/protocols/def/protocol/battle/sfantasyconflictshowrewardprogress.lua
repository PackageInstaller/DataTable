local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFantasyConflictShowRewardProgress = dataclass("SFantasyConflictShowRewardProgress", require("framework.net.protocol"))
SFantasyConflictShowRewardProgress.ProtocolType = 4152
SFantasyConflictShowRewardProgress.MaxSize = 65535
SFantasyConflictShowRewardProgress.totalPoint = 0

function SFantasyConflictShowRewardProgress:Ctor(client)
  SFantasyConflictShowRewardProgress.super.Ctor(self, client)
  self.rewardList = {}
end

function SFantasyConflictShowRewardProgress:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalPoint) then
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
  return true
end

function SFantasyConflictShowRewardProgress:Unmarshal(buffer)
  local ret = true
  ret, self.totalPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  return ret
end

return SFantasyConflictShowRewardProgress
