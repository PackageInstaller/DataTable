---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/7/12 21:15
--- 强壮
---
local Buff_2028 = BaseClass("Buff_2028",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.MaxHpPct,30)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.MaxHpPct,30)
    base.OnRemoved(self)
end

Buff_2028.OnOccur = OnOccur
Buff_2028.OnRemoved = OnRemoved

return Buff_2028