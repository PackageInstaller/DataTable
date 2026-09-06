local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBossChallengeRanking = dataclass("SBossChallengeRanking", require("framework.net.protocol"))
SBossChallengeRanking.ProtocolType = 3502
SBossChallengeRanking.MaxSize = 655350
SBossChallengeRanking.id = 0

function SBossChallengeRanking:Ctor(client)
  SBossChallengeRanking.super.Ctor(self, client)
  self.personRank = require("protocols.bean.protocol.ranking.bosschallenge").Create()
  self.ranking = {}
end

function SBossChallengeRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
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

function SBossChallengeRanking:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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

return SBossChallengeRanking
