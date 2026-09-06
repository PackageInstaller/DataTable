local BattlePauseType = dataclass("BattlePauseType")
BattlePauseType.TimeLine = 1
BattlePauseType.NpcChat = 2

function BattlePauseType:Ctor()
end

function BattlePauseType:Marshal(data)
end

function BattlePauseType:Unmarshal(data)
end

function BattlePauseType:CheckVariable()
  return true
end

return BattlePauseType
