-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/bean/data/battleendtype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleEndType = dataclass("BattleEndType")
BattleEndType.LeftWin = 1
BattleEndType.RightWin = 2
BattleEndType.Drawn = 3
BattleEndType.Retreat = 4
BattleEndType.LeftWinCBattleKill = 5
BattleEndType.RightWinCBattleKill = 6
BattleEndType.RightWinOverTime = 7
BattleEndType.LeftWinOverTime = 8
BattleEndType.LoseSettle = 9
BattleEndType.SkipWin = 10
BattleEndType.Ctor = function(self)
  -- function num : 0_0
end

BattleEndType.Marshal = function(self, data)
  -- function num : 0_1
end

BattleEndType.Unmarshal = function(self, data)
  -- function num : 0_2
end

BattleEndType.CheckVariable = function(self)
  -- function num : 0_3
  return true
end

return BattleEndType

