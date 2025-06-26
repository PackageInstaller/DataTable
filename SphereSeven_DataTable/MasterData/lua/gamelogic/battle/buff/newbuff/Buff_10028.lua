---
--- 攻击提升 攻击力提升50%
---
local Buff_10028 = BaseClass("Buff_10028",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.Hide)
    -- self.TargetUnit:GetComponent("SsUnitBattleComponent"):SetUnitColorAlpha(0.3)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.Hide)
    -- self.TargetUnit:GetComponent("SsUnitBattleComponent"):SetUnitColorAlpha(1)
    base.OnRemoved(self)
end

local function BeforeBeHit(self, activeSkillResult, atkUnit)
    base.BeforeBeHit(self, activeSkillResult, atkUnit)
    activeSkillResult.UltimateScale = 0.5

    if not self.IsCannotDispelled then
        self.IsRemoved = true
        self:OnRemoved()
    end
end

Buff_10028.OnOccur = OnOccur
Buff_10028.OnRemoved = OnRemoved
Buff_10028.BeforeBeHit = BeforeBeHit

return Buff_10028