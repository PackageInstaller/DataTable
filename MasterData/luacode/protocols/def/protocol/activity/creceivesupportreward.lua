local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveSupportReward = dataclass("CReceiveSupportReward", require("framework.net.protocol"))
CReceiveSupportReward.ProtocolType = 2566
CReceiveSupportReward.MaxSize = 65535
CReceiveSupportReward.rewardType = 0
CReceiveSupportReward.id = 0

function CReceiveSupportReward:Ctor(client)
  CReceiveSupportReward.super.Ctor(self, client)
end

function CReceiveSupportReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveSupportReward:Unmarshal(buffer)
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

return CReceiveSupportReward
