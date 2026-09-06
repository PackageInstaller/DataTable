local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveSupportReward = dataclass("SReceiveSupportReward", require("framework.net.protocol"))
SReceiveSupportReward.ProtocolType = 2567
SReceiveSupportReward.MaxSize = 65535
SReceiveSupportReward.rewardType = 0
SReceiveSupportReward.id = 0

function SReceiveSupportReward:Ctor(client)
  SReceiveSupportReward.super.Ctor(self, client)
end

function SReceiveSupportReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function SReceiveSupportReward:Unmarshal(buffer)
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

return SReceiveSupportReward
