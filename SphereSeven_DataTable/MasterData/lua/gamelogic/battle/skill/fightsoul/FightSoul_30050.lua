---
--- 攻击力提升${Params[1]}%,每个自身回合结束时,这个加成下降${Params[2]}%,最低下降到${Params[3]}%。
---

local FightSoul_30050 = BaseClass("FightSoul_30050",Skill)
local base = Skill

local function __init(self)
    self.Data.AtkAddPct = self.Params[1]
    self.Data.AtkReducePct = self.Params[2]
    self.Data.AtkPctMin = self.Params[3]

    self.CurAtkAddPct = 0
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AtkPct, self.Data.AtkAddPct)
    self.CurAtkAddPct = self.Data.AtkAddPct
end


local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    if self.CurAtkAddPct <= self.Data.AtkPctMin then
        return
    end

    self.__snc:Dec(NumericType.AtkPct, self.Data.AtkReducePct)
    self.CurAtkAddPct = self.CurAtkAddPct - self.Data.AtkReducePct
end

FightSoul_30050.__init = __init
FightSoul_30050.OnBattleStart = OnBattleStart
FightSoul_30050.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return FightSoul_30050