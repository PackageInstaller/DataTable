---
--- 攻击提升 攻击力提升50%
---
local Buff_10026 = BaseClass("Buff_10026",Buff)
local base = Buff

local function __init(self)
    self.IsNotTurnBuff = true
end

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.ImmuneAllDamage)
end

local function AfterAllHurt(self, atkUnit, activeSkillResult)
    base.AfterAllHurt(self, atkUnit, activeSkillResult)

    self.IsRemoved = true
    self:OnRemoved()
end


local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.ImmuneAllDamage)
    base.OnRemoved(self)
end

Buff_10026.__init = __init
Buff_10026.OnOccur = OnOccur
Buff_10026.OnRemoved = OnRemoved
Buff_10026.AfterAllHurt = AfterAllHurt

return Buff_10026