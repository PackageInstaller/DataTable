---
--- 攻击提升 攻击力提升50%
---
local Buff_20019 = BaseClass("Buff_20019",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.MagicDefPct,50)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableAct)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.MagicDefPct,50)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableAct)
    base.OnRemoved(self)
end

local function AfterHurt(self, result, atkUnit)
    self:DecLeftTurn()
end

Buff_20019.OnOccur = OnOccur
Buff_20019.OnRemoved = OnRemoved
Buff_20019.AfterHurt = AfterHurt

return Buff_20019