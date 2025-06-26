---
--- 攻击提升 攻击力提升50%
---
local Buff_10004 = BaseClass("Buff_10004",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.DefPct,90)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.DefPct,90)
    base.OnRemoved(self)
end

Buff_10004.OnOccur = OnOccur
Buff_10004.OnRemoved = OnRemoved

return Buff_10004