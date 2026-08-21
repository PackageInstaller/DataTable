---
--- 被冻结
--- 易伤50%
---
local Buff_20018 = BaseClass("Buff_20018",Buff)
local base = Buff

local function __init(self, buffId, fromSkillId, srcUnit, targetUnit, isDeBuff, name)
    self._preventHurtReduce = false
end

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.DefPct,50)
    self.__tcc:IncSpecialEffect(SpecialEffectType.UnableAct)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.DefPct,50)
    self.__tcc:DecSpecialEffect(SpecialEffectType.UnableAct)
    base.OnRemoved(self)
end

local function AfterAllHurt(self, atkUnit, activeSkillResult)
    base.AfterAllHurt(self, atkUnit, activeSkillResult)

    if not self._preventHurtReduce then
        self:DecLeftTurn()
    end

    self._preventHurtReduce = false
end


local function PreventHurtReduce(self)
    self._preventHurtReduce = true
end

Buff_20018.__init = __init
Buff_20018.OnOccur = OnOccur
Buff_20018.OnRemoved = OnRemoved
Buff_20018.AfterAllHurt = AfterAllHurt

Buff_20018.PreventHurtReduce = PreventHurtReduce

return Buff_20018