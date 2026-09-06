local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveSummerReward = dataclass("CReceiveSummerReward", require("framework.net.protocol"))
CReceiveSummerReward.ProtocolType = 2721
CReceiveSummerReward.MaxSize = 65535
CReceiveSummerReward.rewardId = 0

function CReceiveSummerReward:Ctor(client)
  CReceiveSummerReward.super.Ctor(self, client)
end

function CReceiveSummerReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardId) then
    return false
  end
  return true
end

function CReceiveSummerReward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveSummerReward
