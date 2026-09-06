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

function BattleEndType:Ctor()
end

function BattleEndType:Marshal(data)
end

function BattleEndType:Unmarshal(data)
end

function BattleEndType:CheckVariable()
  return true
end

return BattleEndType
