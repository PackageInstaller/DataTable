local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUNDRChallengeRanking = dataclass("CUNDRChallengeRanking", require("framework.net.protocol"))
CUNDRChallengeRanking.ProtocolType = 3511
CUNDRChallengeRanking.MaxSize = 65535
CUNDRChallengeRanking.seasonId = 0
CUNDRChallengeRanking.day = 0

function CUNDRChallengeRanking:Ctor(client)
  CUNDRChallengeRanking.super.Ctor(self, client)
end

function CUNDRChallengeRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.seasonId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.day) then
    return false
  end
  return true
end

function CUNDRChallengeRanking:Unmarshal(buffer)
  local ret = true
  ret, self.seasonId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.day = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUNDRChallengeRanking
