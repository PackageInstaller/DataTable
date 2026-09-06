local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAgainstBossGetWeeklyAwards = dataclass("CAgainstBossGetWeeklyAwards", require("framework.net.protocol"))
CAgainstBossGetWeeklyAwards.ProtocolType = 2671
CAgainstBossGetWeeklyAwards.MaxSize = 65535
CAgainstBossGetWeeklyAwards.weeklyAwardId = 0

function CAgainstBossGetWeeklyAwards:Ctor(client)
  CAgainstBossGetWeeklyAwards.super.Ctor(self, client)
end

function CAgainstBossGetWeeklyAwards:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.weeklyAwardId) then
    return false
  end
  return true
end

function CAgainstBossGetWeeklyAwards:Unmarshal(buffer)
  local ret = true
  ret, self.weeklyAwardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAgainstBossGetWeeklyAwards
