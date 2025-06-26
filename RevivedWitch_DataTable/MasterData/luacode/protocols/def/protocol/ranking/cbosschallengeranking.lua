-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/cbosschallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBossChallengeRanking = dataclass("CBossChallengeRanking", require("framework.net.protocol"))
CBossChallengeRanking.ProtocolType = 3501
CBossChallengeRanking.MaxSize = 65535
CBossChallengeRanking.id = 0
CBossChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBossChallengeRanking
  ((CBossChallengeRanking.super).Ctor)(self, client)
end

CBossChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CBossChallengeRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBossChallengeRanking

