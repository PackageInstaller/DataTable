local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SWeekBossRedPoint = dataclass("SWeekBossRedPoint", require("framework.net.protocol"))
SWeekBossRedPoint.ProtocolType = 4142
SWeekBossRedPoint.MaxSize = 65535
SWeekBossRedPoint.redType = 0
SWeekBossRedPoint.UNLOCK_NIGHTMARE = 1
SWeekBossRedPoint.RECEIVE_REWARD = 2
SWeekBossRedPoint.UNLOCK_TALENT = 3

function SWeekBossRedPoint:Ctor(client)
  SWeekBossRedPoint.super.Ctor(self, client)
end

function SWeekBossRedPoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redType) then
    return false
  end
  return true
end

function SWeekBossRedPoint:Unmarshal(buffer)
  local ret = true
  ret, self.redType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SWeekBossRedPoint
