---
--- 攻击提升 攻击力提升50%
---
local Buff_20008 = BaseClass("Buff_20008",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableRecHeal)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableRecHeal)
    base.OnRemoved(self)
end

Buff_20008.OnOccur = OnOccur
Buff_20008.OnRemoved = OnRemoved

return Buff_20008