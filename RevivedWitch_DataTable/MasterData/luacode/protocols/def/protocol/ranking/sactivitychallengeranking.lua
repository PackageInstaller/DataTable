-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/sactivitychallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SActivityChallengeRanking = dataclass("SActivityChallengeRanking", require("framework.net.protocol"))
SActivityChallengeRanking.ProtocolType = 3510
SActivityChallengeRanking.MaxSize = 655350
SActivityChallengeRanking.activity = 0
SActivityChallengeRanking.id = 0
SActivityChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SActivityChallengeRanking, _ENV
  ((SActivityChallengeRanking.super).Ctor)(self, client)
  self.personRank = ((require("protocols.bean.protocol.ranking.bosschallenge")).Create)()
  self.ranking = {}
end

SActivityChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activity) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
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

SActivityChallengeRanking.Unmarshal = function(self, buffer)
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
  if not (self.personRank):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

    (self.ranking)[i] = ((require("protocols.bean.protocol.ranking.bosschallenge")).Create)()
    if not ((self.ranking)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SActivityChallengeRanking

