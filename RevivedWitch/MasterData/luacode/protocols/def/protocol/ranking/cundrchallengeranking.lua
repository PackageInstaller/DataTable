-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/cundrchallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUNDRChallengeRanking = dataclass("CUNDRChallengeRanking", require("framework.net.protocol"))
CUNDRChallengeRanking.ProtocolType = 3511
CUNDRChallengeRanking.MaxSize = 65535
CUNDRChallengeRanking.seasonId = 0
CUNDRChallengeRanking.day = 0
CUNDRChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUNDRChallengeRanking
  ((CUNDRChallengeRanking.super).Ctor)(self, client)
end

CUNDRChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.seasonId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.day) then
    return false
  end
  return true
end

CUNDRChallengeRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUNDRChallengeRanking

