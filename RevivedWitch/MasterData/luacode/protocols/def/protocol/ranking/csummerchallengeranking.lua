-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/csummerchallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSummerChallengeRanking = dataclass("CSummerChallengeRanking", require("framework.net.protocol"))
CSummerChallengeRanking.ProtocolType = 3524
CSummerChallengeRanking.MaxSize = 65535
CSummerChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSummerChallengeRanking
  ((CSummerChallengeRanking.super).Ctor)(self, client)
end

CSummerChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CSummerChallengeRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CSummerChallengeRanking

