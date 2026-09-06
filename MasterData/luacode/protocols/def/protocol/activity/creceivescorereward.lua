local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveScoreReward = dataclass("CReceiveScoreReward", require("framework.net.protocol"))
CReceiveScoreReward.ProtocolType = 2536
CReceiveScoreReward.MaxSize = 65535
CReceiveScoreReward.scoreType = 0
CReceiveScoreReward.rewardId = 0

function CReceiveScoreReward:Ctor(client)
  CReceiveScoreReward.super.Ctor(self, client)
end

function CReceiveScoreReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.scoreType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardId) then
    return false
  end
  return true
end

function CReceiveScoreReward:Unmarshal(buffer)
  local ret = true
  ret, self.scoreType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rewardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveScoreReward
