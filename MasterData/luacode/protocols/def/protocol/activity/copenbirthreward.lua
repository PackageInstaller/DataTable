local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CopenBirthReward = dataclass("CopenBirthReward", require("framework.net.protocol"))
CopenBirthReward.ProtocolType = 2545
CopenBirthReward.MaxSize = 65535
CopenBirthReward.rewardId = 0

function CopenBirthReward:Ctor(client)
  CopenBirthReward.super.Ctor(self, client)
end

function CopenBirthReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardId) then
    return false
  end
  return true
end

function CopenBirthReward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CopenBirthReward
