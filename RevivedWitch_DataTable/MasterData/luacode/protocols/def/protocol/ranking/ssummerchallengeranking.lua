-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/ssummerchallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSummerChallengeRanking = dataclass("SSummerChallengeRanking", require("framework.net.protocol"))
SSummerChallengeRanking.ProtocolType = 3525
SSummerChallengeRanking.MaxSize = 655350
SSummerChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSummerChallengeRanking, _ENV
  ((SSummerChallengeRanking.super).Ctor)(self, client)
  self.personRank = ((require("protocols.bean.protocol.ranking.undrchallenge")).Create)()
  self.ranking = {}
end

SSummerChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  if not (self.personRank):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.ranking)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.ranking)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SSummerChallengeRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  if not (self.personRank):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.ranking)[i] = ((require("protocols.bean.protocol.ranking.undrchallenge")).Create)()
    if not ((self.ranking)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SSummerChallengeRanking

