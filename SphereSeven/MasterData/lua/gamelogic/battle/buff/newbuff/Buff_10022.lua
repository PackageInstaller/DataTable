---
--- 攻击提升 攻击力提升50%
---
local Buff_10022 = BaseClass("Buff_10022",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.ImmuneAllDamage)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.ImmuneAllDamage)
    base.OnRemoved(self)
end

Buff_10022.OnOccur = OnOccur
Buff_10022.OnRemoved = OnRemoved

return Buff_10022