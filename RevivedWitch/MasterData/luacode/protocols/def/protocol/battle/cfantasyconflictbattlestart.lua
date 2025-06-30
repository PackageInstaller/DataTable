-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cfantasyconflictbattlestart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFantasyConflictBattleStart = dataclass("CFantasyConflictBattleStart", require("framework.net.protocol"))
CFantasyConflictBattleStart.ProtocolType = 4159
CFantasyConflictBattleStart.MaxSize = 65535
CFantasyConflictBattleStart.enemyID = 0
CFantasyConflictBattleStart.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFantasyConflictBattleStart
  ((CFantasyConflictBattleStart.super).Ctor)(self, client)
end

CFantasyConflictBattleStart.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.enemyID) then
    return false
  end
  return true
end

CFantasyConflictBattleStart.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFantasyConflictBattleStart

