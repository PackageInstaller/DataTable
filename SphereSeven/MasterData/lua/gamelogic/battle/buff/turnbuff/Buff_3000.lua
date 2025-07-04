---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/7/13 1:58
--- 属性增益buff
---
local Buff_3000 = BaseClass("Buff_3000",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(self.NumericType,self.NumericVal)
end

local function OnMultiply(self, val)
    base.OnMultiply(self, val)
    self.__tnc:Inc(self.NumericType, val)
end

local function OnRemoved(self)
    self.__tnc:Dec(self.NumericType,self.NumericVal)
    base.OnRemoved(self)
end

Buff_3000.OnOccur = OnOccur
Buff_3000.OnMultiply = OnMultiply
Buff_3000.OnRemoved = OnRemoved

return Buff_3000