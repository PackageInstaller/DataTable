local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SWatermelonChallengeRanking = dataclass("SWatermelonChallengeRanking", require("framework.net.protocol"))
SWatermelonChallengeRanking.ProtocolType = 3516
SWatermelonChallengeRanking.MaxSize = 655350
SWatermelonChallengeRanking.id = 0

function SWatermelonChallengeRanking:Ctor(client)
  SWatermelonChallengeRanking.super.Ctor(self, client)
  self.personRank = require("protocols.bean.protocol.ranking.watermelonchallenge").Create()
  self.ranking = {}
end

function SWatermelonChallengeRanking:Marshal(buffer)
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

function SWatermelonChallengeRanking:Unmarshal(buffer)
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
    self.ranking[i] = require("protocols.bean.protocol.ranking.watermelonchallenge").Create()
    if not self.ranking[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SWatermelonChallengeRanking
