---
--- 攻击提升 攻击力提升50%
---
local Buff_20013 = BaseClass("Buff_20013",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableAct)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableAct)
    base.OnRemoved(self)
end

Buff_20013.OnOccur = OnOccur
Buff_20013.OnRemoved = OnRemoved

return Buff_20013