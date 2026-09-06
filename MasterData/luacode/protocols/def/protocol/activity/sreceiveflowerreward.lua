local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveFlowerReward = dataclass("SReceiveFlowerReward", require("framework.net.protocol"))
SReceiveFlowerReward.ProtocolType = 2603
SReceiveFlowerReward.MaxSize = 65535
SReceiveFlowerReward.rewardType = 0
SReceiveFlowerReward.id = 0

function SReceiveFlowerReward:Ctor(client)
  SReceiveFlowerReward.super.Ctor(self, client)
end

function SReceiveFlowerReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function SReceiveFlowerReward:Unmarshal(buffer)
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

return SReceiveFlowerReward
