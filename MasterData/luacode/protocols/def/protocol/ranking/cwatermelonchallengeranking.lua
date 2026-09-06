local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CWatermelonChallengeRanking = dataclass("CWatermelonChallengeRanking", require("framework.net.protocol"))
CWatermelonChallengeRanking.ProtocolType = 3515
CWatermelonChallengeRanking.MaxSize = 65535
CWatermelonChallengeRanking.id = 0

function CWatermelonChallengeRanking:Ctor(client)
  CWatermelonChallengeRanking.super.Ctor(self, client)
end

function CWatermelonChallengeRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CWatermelonChallengeRanking:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CWatermelonChallengeRanking
