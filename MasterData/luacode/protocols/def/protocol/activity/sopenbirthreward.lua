local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SopenBirthReward = dataclass("SopenBirthReward", require("framework.net.protocol"))
SopenBirthReward.ProtocolType = 2546
SopenBirthReward.MaxSize = 65535
SopenBirthReward.rewardId = 0

function SopenBirthReward:Ctor(client)
  SopenBirthReward.super.Ctor(self, client)
end

function SopenBirthReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardId) then
    return false
  end
  return true
end

function SopenBirthReward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SopenBirthReward
