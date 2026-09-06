local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUNDRChallengeRanking = dataclass("SUNDRChallengeRanking", require("framework.net.protocol"))
SUNDRChallengeRanking.ProtocolType = 3512
SUNDRChallengeRanking.MaxSize = 655350
SUNDRChallengeRanking.seasonId = 0
SUNDRChallengeRanking.day = 0

function SUNDRChallengeRanking:Ctor(client)
  SUNDRChallengeRanking.super.Ctor(self, client)
  self.personRank = require("protocols.bean.protocol.ranking.undrchallenge").Create()
  self.ranking = {}
end

function SUNDRChallengeRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.seasonId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.day) then
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

function SUNDRChallengeRanking:Unmarshal(buffer)
  local ret = true
  ret, self.seasonId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.day = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.ranking[i] = require("protocols.bean.protocol.ranking.undrchallenge").Create()
    if not self.ranking[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUNDRChallengeRanking
