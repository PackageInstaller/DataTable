-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sbattlestart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBattleStart = dataclass("SBattleStart", require("framework.net.protocol"))
SBattleStart.ProtocolType = 1902
SBattleStart.MaxSize = 655350
SBattleStart.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBattleStart, _ENV
  ((SBattleStart.super).Ctor)(self, client)
  self.battleInfo = ((require("protocols.bean.protocol.battle.battleinfo")).Create)()
end

SBattleStart.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.battleInfo):Marshal(buffer) then
    return false
  end
  return true
end

SBattleStart.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.battleInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SBattleStart

