---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/19 17:05
--- 狂暴
---
local Buff_2021 = BaseClass("Buff_2021",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.AtkPct,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.AtkPct,50)
    base.OnRemoved(self)
end

Buff_2021.OnOccur = OnOccur
Buff_2021.OnRemoved = OnRemoved

return Buff_2021