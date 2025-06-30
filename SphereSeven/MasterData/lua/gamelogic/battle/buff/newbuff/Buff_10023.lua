---
--- 攻击提升 攻击力提升50%
---
local Buff_10023 = BaseClass("Buff_10023",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.Immortal)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.Immortal)
    base.OnRemoved(self)
end

Buff_10023.OnOccur = OnOccur
Buff_10023.OnRemoved = OnRemoved

return Buff_10023