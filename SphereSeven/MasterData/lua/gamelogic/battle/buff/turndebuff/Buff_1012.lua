---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/7/11 17:49
--- 消沉
---
local Buff_1012 = BaseClass("Buff_1012",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.HitAdd,50)
    self.__tnc:Dec(NumericType.PryAdd,50)
    self.__tnc:Dec(NumericType.StmAdd,50)
    self.__tsc:OnPassiveSkillDisabled()
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.HitAdd,50)
    self.__tnc:Inc(NumericType.PryAdd,50)
    self.__tnc:Inc(NumericType.StmAdd,50)
    self.__tsc:OnPassiveSkillEnabled()
    base.OnRemoved(self)
end

Buff_1012.OnOccur = OnOccur
Buff_1012.OnRemoved = OnRemoved

return Buff_1012