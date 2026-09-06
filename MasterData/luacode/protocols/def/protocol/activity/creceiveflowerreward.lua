local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveFlowerReward = dataclass("CReceiveFlowerReward", require("framework.net.protocol"))
CReceiveFlowerReward.ProtocolType = 2602
CReceiveFlowerReward.MaxSize = 65535
CReceiveFlowerReward.rewardType = 0
CReceiveFlowerReward.id = 0

function CReceiveFlowerReward:Ctor(client)
  CReceiveFlowerReward.super.Ctor(self, client)
end

function CReceiveFlowerReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveFlowerReward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveFlowerReward
