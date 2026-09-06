local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveAchieveLevelAward = dataclass("SReceiveAchieveLevelAward", require("framework.net.protocol"))
SReceiveAchieveLevelAward.ProtocolType = 1622
SReceiveAchieveLevelAward.MaxSize = 65535
SReceiveAchieveLevelAward.level = 0

function SReceiveAchieveLevelAward:Ctor(client)
  SReceiveAchieveLevelAward.super.Ctor(self, client)
end

function SReceiveAchieveLevelAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  return true
end

function SReceiveAchieveLevelAward:Unmarshal(buffer)
  local ret = true
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveAchieveLevelAward
