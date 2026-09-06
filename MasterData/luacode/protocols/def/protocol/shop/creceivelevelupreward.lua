local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveLevelUpReward = dataclass("CReceiveLevelUpReward", require("framework.net.protocol"))
CReceiveLevelUpReward.ProtocolType = 3637
CReceiveLevelUpReward.MaxSize = 65535
CReceiveLevelUpReward.id = 0

function CReceiveLevelUpReward:Ctor(client)
  CReceiveLevelUpReward.super.Ctor(self, client)
end

function CReceiveLevelUpReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveLevelUpReward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveLevelUpReward
