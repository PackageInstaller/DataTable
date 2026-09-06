local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBossChallengeRanking = dataclass("CBossChallengeRanking", require("framework.net.protocol"))
CBossChallengeRanking.ProtocolType = 3501
CBossChallengeRanking.MaxSize = 65535
CBossChallengeRanking.id = 0

function CBossChallengeRanking:Ctor(client)
  CBossChallengeRanking.super.Ctor(self, client)
end

function CBossChallengeRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CBossChallengeRanking:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBossChallengeRanking
