---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
---沉默Buff
--- DateTime: 2019/4/19 18:27
---
local Buff_1007 = BaseClass("Buff_1007",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableSkill)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableCri)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableSkill)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableCri)
    base.OnRemoved(self)
end

Buff_1007.OnOccur = OnOccur
Buff_1007.OnRemoved = OnRemoved

return Buff_1007