---
--- 攻击提升 攻击力提升50%
---
local Buff_20020 = BaseClass("Buff_20020",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.Paralysis)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.Paralysis)
    base.OnRemoved(self)
end

Buff_20020.OnOccur = OnOccur
Buff_20020.OnRemoved = OnRemoved

return Buff_20020