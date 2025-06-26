---
--- 攻击力提升${Params[1]}%。回合开始时, ${Params[2]}%的概率获得${Params[3]}回合的【攻击力提升大】
---

local FightSoul_40006 = BaseClass("FightSoul_40006",Skill)
local base = Skill

local function __init(self)
    self.Data.AtkPct = self.Params[1]
    self.Data.Probably = self.Params[2]
    self.Data.BuffTurn = math.modf(self.Params[3])
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AtkPct, self.Data.AtkPct)
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnEnd(self)

    if BattleUtil.IsPctProbHit(self.Data.Probably) then
        self.SrcUnit:GetComponent("BuffComponent"):CreateBuff(BattleBuffType.AtkIncrease2, self.SkillId, self.SrcUnit, self.SrcUnit, self.Data.BuffTurn)
    end
end

FightSoul_40006.__init = __init
FightSoul_40006.OnBattleStart = OnBattleStart
FightSoul_40006.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return FightSoul_40006