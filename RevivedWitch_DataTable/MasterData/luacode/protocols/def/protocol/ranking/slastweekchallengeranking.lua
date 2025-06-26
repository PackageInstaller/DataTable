-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/slastweekchallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLastWeekChallengeRanking = dataclass("SLastWeekChallengeRanking", require("framework.net.protocol"))
SLastWeekChallengeRanking.ProtocolType = 3521
SLastWeekChallengeRanking.MaxSize = 655350
SLastWeekChallengeRanking.rankId = 0
SLastWeekChallengeRanking.bossId = 0
SLastWeekChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLastWeekChallengeRanking
  ((SLastWeekChallengeRanking.super).Ctor)(self, client)
  self.topThreeRank = {}
end

SLastWeekChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rankId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossId) then
    return false
  end
  local length = (table.slen)(self.topThreeRank)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.topThreeRank)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SLastWeekChallengeRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.topThreeRank)[i] = ((require("protocols.bean.protocol.ranking.bosschallenge")).Create)()
    if not ((self.topThreeRank)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SLastWeekChallengeRanking

