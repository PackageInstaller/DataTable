local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSpringBossRewardRedPoint = dataclass("SSpringBossRewardRedPoint", require("framework.net.protocol"))
SSpringBossRewardRedPoint.ProtocolType = 2608
SSpringBossRewardRedPoint.MaxSize = 65535
SSpringBossRewardRedPoint.show = 0

function SSpringBossRewardRedPoint:Ctor(client)
  SSpringBossRewardRedPoint.super.Ctor(self, client)
end

function SSpringBossRewardRedPoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.show) then
    return false
  end
  return true
end

function SSpringBossRewardRedPoint:Unmarshal(buffer)
  local ret = true
  ret, self.show = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSpringBossRewardRedPoint
