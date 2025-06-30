-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/cwatermelonchallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CWatermelonChallengeRanking = dataclass("CWatermelonChallengeRanking", require("framework.net.protocol"))
CWatermelonChallengeRanking.ProtocolType = 3515
CWatermelonChallengeRanking.MaxSize = 65535
CWatermelonChallengeRanking.id = 0
CWatermelonChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CWatermelonChallengeRanking
  ((CWatermelonChallengeRanking.super).Ctor)(self, client)
end

CWatermelonChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CWatermelonChallengeRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CWatermelonChallengeRanking

