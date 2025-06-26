---
--- 攻击提升 攻击力提升50%
---
local Buff_10003 = BaseClass("Buff_10003",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.DefPct,60)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.DefPct,60)
    base.OnRemoved(self)
end

Buff_10003.OnOccur = OnOccur
Buff_10003.OnRemoved = OnRemoved

return Buff_10003