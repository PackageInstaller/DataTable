local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveReward = dataclass("CReceiveReward", require("framework.net.protocol"))
CReceiveReward.ProtocolType = 2489
CReceiveReward.MaxSize = 65535
CReceiveReward.rewardId = 0

function CReceiveReward:Ctor(client)
  CReceiveReward.super.Ctor(self, client)
end

function CReceiveReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardId) then
    return false
  end
  return true
end

function CReceiveReward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveReward
