-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sbattlescore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBattleScore = dataclass("SBattleScore", require("framework.net.protocol"))
SBattleScore.ProtocolType = 2725
SBattleScore.MaxSize = 65535
SBattleScore.score = 0
SBattleScore.totalScore = 0
SBattleScore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBattleScore
  ((SBattleScore.super).Ctor)(self, client)
end

SBattleScore.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.score) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalScore) then
    return false
  end
  return true
end

SBattleScore.Unmarshal = function(self, buffer)
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

return SBattleScore

