local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveAchieveLevelAward = dataclass("CReceiveAchieveLevelAward", require("framework.net.protocol"))
CReceiveAchieveLevelAward.ProtocolType = 1621
CReceiveAchieveLevelAward.MaxSize = 65535
CReceiveAchieveLevelAward.level = 0

function CReceiveAchieveLevelAward:Ctor(client)
  CReceiveAchieveLevelAward.super.Ctor(self, client)
end

function CReceiveAchieveLevelAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  return true
end

function CReceiveAchieveLevelAward:Unmarshal(buffer)
  local ret = true
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveAchieveLevelAward
