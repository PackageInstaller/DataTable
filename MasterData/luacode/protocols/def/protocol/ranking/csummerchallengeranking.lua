local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSummerChallengeRanking = dataclass("CSummerChallengeRanking", require("framework.net.protocol"))
CSummerChallengeRanking.ProtocolType = 3524
CSummerChallengeRanking.MaxSize = 65535

function CSummerChallengeRanking:Ctor(client)
  CSummerChallengeRanking.super.Ctor(self, client)
end

function CSummerChallengeRanking:Marshal(buffer)
  return true
end

function CSummerChallengeRanking:Unmarshal(buffer)
  local ret = true
  return ret
end

return CSummerChallengeRanking
