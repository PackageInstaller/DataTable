local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SActivityChallengeRanking = dataclass("SActivityChallengeRanking", require("framework.net.protocol"))
SActivityChallengeRanking.ProtocolType = 3510
SActivityChallengeRanking.MaxSize = 655350
SActivityChallengeRanking.activity = 0
SActivityChallengeRanking.id = 0

function SActivityChallengeRanking:Ctor(client)
  SActivityChallengeRanking.super.Ctor(self, client)
  self.personRank = require("protocols.bean.protocol.ranking.bosschallenge").Create()
  self.ranking = {}
end

function SActivityChallengeRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activity) then
    return false
  end
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

function SActivityChallengeRanking:Unmarshal(buffer)
  local ret = true
  ret, self.activity = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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

return SActivityChallengeRanking
