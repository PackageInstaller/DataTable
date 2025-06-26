---
--- 攻击提升 攻击力提升50%
---
local Buff_20014 = BaseClass("Buff_20014",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableAct)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableAct)
    base.OnRemoved(self)
end

Buff_20014.OnOccur = OnOccur
Buff_20014.OnRemoved = OnRemoved

return Buff_20014