---
--- 攻击提升 攻击力提升50%
---
local Buff_20021 = BaseClass("Buff_20021",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.PryAdd,30)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableIncActValue)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.PryAdd,30)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableIncActValue)
    base.OnRemoved(self)
end

Buff_20021.OnOccur = OnOccur
Buff_20021.OnRemoved = OnRemoved

return Buff_20021