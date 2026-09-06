local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CActivityChallengeRanking = dataclass("CActivityChallengeRanking", require("framework.net.protocol"))
CActivityChallengeRanking.ProtocolType = 3509
CActivityChallengeRanking.MaxSize = 65535
CActivityChallengeRanking.activity = 0
CActivityChallengeRanking.id = 0

function CActivityChallengeRanking:Ctor(client)
  CActivityChallengeRanking.super.Ctor(self, client)
end

function CActivityChallengeRanking:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activity) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CActivityChallengeRanking:Unmarshal(buffer)
  local ret = true
  ret, self.activity = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActivityChallengeRanking
