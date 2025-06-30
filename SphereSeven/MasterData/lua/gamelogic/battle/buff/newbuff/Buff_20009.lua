---
--- 攻击提升 攻击力提升50%
---
local Buff_20009 = BaseClass("Buff_20009",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableBuff)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableBuff)
    base.OnRemoved(self)
end

Buff_20009.OnOccur = OnOccur
Buff_20009.OnRemoved = OnRemoved

return Buff_20009