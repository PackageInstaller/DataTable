local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SWeekChallengeRanking = dataclass("SWeekChallengeRanking", require("framework.net.protocol"))
SWeekChallengeRanking.ProtocolType = 3520
SWeekChallengeRanking.MaxSize = 655350

function SWeekChallengeRanking:Ctor(client)
  SWeekChallengeRanking.super.Ctor(self, client)
  self.personRank = require("protocols.bean.protocol.ranking.bosschallenge").Create()
  self.ranking = {}
end

function SWeekChallengeRanking:Marshal(buffer)
  if not self.personRank:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.ranking)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.ranking[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SWeekChallengeRanking:Unmarshal(buffer)
  local ret = true
  if not self.personRank:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.ranking[i] = require("protocols.bean.protocol.ranking.bosschallenge").Create()
    if not self.ranking[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SWeekChallengeRanking
