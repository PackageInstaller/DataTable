-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/cactivitychallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CActivityChallengeRanking = dataclass("CActivityChallengeRanking", require("framework.net.protocol"))
CActivityChallengeRanking.ProtocolType = 3509
CActivityChallengeRanking.MaxSize = 65535
CActivityChallengeRanking.activity = 0
CActivityChallengeRanking.id = 0
CActivityChallengeRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CActivityChallengeRanking
  ((CActivityChallengeRanking.super).Ctor)(self, client)
end

CActivityChallengeRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activity) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CActivityChallengeRanking.Unmarshal = function(self, buffer)
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

return CActivityChallengeRanking

