---
--- 攻击提升 攻击力提升50%
---
local Buff_20011 = BaseClass("Buff_20011",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableSkill)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableSkill)
    base.OnRemoved(self)
end

Buff_20011.OnOccur = OnOccur
Buff_20011.OnRemoved = OnRemoved

return Buff_20011