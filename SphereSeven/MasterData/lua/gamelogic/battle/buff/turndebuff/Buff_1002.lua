---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
---冻结Buff
--- DateTime: 2019/4/19 16:27
---水属性造成的特殊效果，使对方无法行动，受到普通攻击的伤害＋20%。
local Buff_1002 = BaseClass("Buff_1002",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableAct)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableCac)
    self.__tnc:Dec(NumericType.GAtkFinalHurtAdd,20)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableAct)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableCac)
    self.__tnc:Inc(NumericType.GAtkFinalHurtAdd,20)
    base.OnRemoved(self)
end

Buff_1002.OnOccur = OnOccur
Buff_1002.OnRemoved = OnRemoved

return Buff_1002