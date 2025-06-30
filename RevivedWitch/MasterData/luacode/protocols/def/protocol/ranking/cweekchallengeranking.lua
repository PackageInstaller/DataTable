-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/cweekchallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CWeekChallengeRanking = dataclass("CWeekChallengeRanking", require("framework.net.protocol"))
CWeekChallengeRanking.ProtocolType = 3519
CWeekChallengeRanking.MaxSize = 65535
CWeekChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CWeekChallengeRanking
  ((CWeekChallengeRanking.super).Ctor)(self, client)
end

CWeekChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CWeekChallengeRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CWeekChallengeRanking

