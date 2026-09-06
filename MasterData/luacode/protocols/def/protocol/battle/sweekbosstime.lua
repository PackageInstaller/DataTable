local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SWeekBossTime = dataclass("SWeekBossTime", require("framework.net.protocol"))
SWeekBossTime.ProtocolType = 4147
SWeekBossTime.MaxSize = 65535
SWeekBossTime.leftTime = 0
SWeekBossTime.resetTime = 0
SWeekBossTime.nightmareTime = 0

function SWeekBossTime:Ctor(client)
  SWeekBossTime.super.Ctor(self, client)
end

function SWeekBossTime:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.resetTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.nightmareTime) then
    return false
  end
  return true
end

function SWeekBossTime:Unmarshal(buffer)
  local ret = true
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.resetTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.nightmareTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SWeekBossTime
