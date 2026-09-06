local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetHalloweenReward = dataclass("CGetHalloweenReward", require("framework.net.protocol"))
CGetHalloweenReward.ProtocolType = 2514
CGetHalloweenReward.MaxSize = 65535
CGetHalloweenReward.rewardId = 0

function CGetHalloweenReward:Ctor(client)
  CGetHalloweenReward.super.Ctor(self, client)
end

function CGetHalloweenReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardId) then
    return false
  end
  return true
end

function CGetHalloweenReward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetHalloweenReward
