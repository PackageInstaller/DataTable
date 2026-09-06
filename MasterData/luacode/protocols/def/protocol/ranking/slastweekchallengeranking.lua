local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLastWeekChallengeRanking = dataclass("SLastWeekChallengeRanking", require("framework.net.protocol"))
SLastWeekChallengeRanking.ProtocolType = 3521
SLastWeekChallengeRanking.MaxSize = 655350
SLastWeekChallengeRanking.rankId = 0
SLastWeekChallengeRanking.bossId = 0

function SLastWeekChallengeRanking:Ctor(client)
  SLastWeekChallengeRanking.super.Ctor(self, client)
  self.topThreeRank = {}
end

function SLastWeekChallengeRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rankId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  local length = table.slen(self.topThreeRank)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.topThreeRank[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SLastWeekChallengeRanking:Unmarshal(buffer)
  local ret = true
  ret, self.rankId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.topThreeRank[i] = require("protocols.bean.protocol.ranking.bosschallenge").Create()
    if not self.topThreeRank[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SLastWeekChallengeRanking
