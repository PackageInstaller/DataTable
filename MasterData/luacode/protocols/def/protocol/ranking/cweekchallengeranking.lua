local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CWeekChallengeRanking = dataclass("CWeekChallengeRanking", require("framework.net.protocol"))
CWeekChallengeRanking.ProtocolType = 3519
CWeekChallengeRanking.MaxSize = 65535

function CWeekChallengeRanking:Ctor(client)
  CWeekChallengeRanking.super.Ctor(self, client)
end

function CWeekChallengeRanking:Marshal(buffer)
  return true
end

function CWeekChallengeRanking:Unmarshal(buffer)
  local ret = true
  return ret
end

return CWeekChallengeRanking
